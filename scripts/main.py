import requests, os, psycopg2, psycopg2.extras, random, itertools, collections, pytz, datetime, tweepy, numpy as np

electricitymap_token = os.getenv("AUTH_ELECTRICITYMAP")

# postgres set up
host = "postgres"
dbname = os.getenv("POSTGRES_DB")
user = os.getenv("POSTGRES_USER")
password = os.getenv("POSTGRES_PASSWORD")
conn = psycopg2.connect(f"host={host} dbname={dbname} user={user} password={password}")
cur = conn.cursor()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)


# Twitter set up
access_token_secret = os.getenv("TWEETER_ACCESS_TOKEN_SECRET")
access_token = os.getenv("TWEETER_ACCESS_TOKEN")
consumer_key = os.getenv("TWEETER_CONSUMMER_KEY")
consumer_secret = os.getenv("TWEETER_CONSUMMER_SECRET")

client = tweepy.Client(
    consumer_key=consumer_key,
    consumer_secret=consumer_secret,
    access_token=access_token,
    access_token_secret=access_token_secret,
)


def get_matchups(divisions="all"):
    # We query the divisions
    if divisions == "all":
        cur.execute("select division from public.zone group by 1")
        divisions = cur.fetchall()
        divisions = list(itertools.chain.from_iterable(divisions))
    for division in divisions:
        cur.execute(
            "select country, probability from public.zone where division = %s group by 1, 2",
            (division,),
        )
        query = cur.fetchall()
        country_list = [country[0] for country in query]
        probability_list = [round(float(country[1]), 3) for country in query]
        # We check the previous match up and test it below so we don't do the same matchup twice in a row
        cur.execute(
            "select country from data_fetched where match_id = (select max(match_id) from data_fetched where division = %s)",
            (division,),
        )
        previous_countries = cur.fetchall()
        previous_countries = list(itertools.chain.from_iterable(previous_countries))
        while True:
            choices = np.random.choice(
                country_list, size=2, replace=False, p=probability_list
            )
            if collections.Counter(choices) == collections.Counter(previous_countries):
                continue
            else:
                country1 = choices[0]
                country2 = choices[1]
                break
        get_data(division, country1, country2)


def get_zones(country):
    # First we get the zones for each country
    cur.execute("select zone_id from public.zone where country = %s ", (country,))
    zones_country = cur.fetchall()
    zones_country = list(itertools.chain.from_iterable(zones_country))
    return zones_country


def get_total_consumption(country):
    zones_country = get_zones(country)
    country_consumption_total = []
    for zone in zones_country:
        res = requests.get(
            f"https://api.electricitymap.org/v3/power-breakdown/latest?zone={zone}",
            headers={"auth-token": electricitymap_token},
        ).json()
        country_consumption_total.append(
            sum(res.get("powerConsumptionBreakdown").values())
        )
    return country_consumption_total


def get_co2(country):
    zones_country = get_zones(country)
    country_co2_levels_raw = []
    country_co2_levels_cleaned = []
    country_consumption_total = get_total_consumption(country)

    for zone in zones_country:
        co2 = requests.get(
            f"https://api.electricitymap.org/v3/carbon-intensity/latest?zone={zone}",
            headers={"auth-token": electricitymap_token},
        ).json()
        country_co2_levels_raw.append(co2.get("carbonIntensity"))

    for co2_level, production_level in zip(
        country_co2_levels_raw, country_consumption_total
    ):
        country_co2_levels_cleaned.append(co2_level * production_level)

    co2 = round(sum(country_co2_levels_cleaned) / sum(country_consumption_total))
    return co2


def get_mix(country):
    zones_country = get_zones(country)
    mix = {
        "nuclear": 0,
        "geothermal": 0,
        "biomass": 0,
        "coal": 0,
        "wind": 0,
        "solar": 0,
        "hydro": 0,
        "gas": 0,
        "oil": 0,
        "unknown": 0,
        "hydro discharge": 0,
        "battery discharge": 0,
    }
    mix["total_consumption"] = sum(get_total_consumption(country))
    print(country)
    print(mix["total_consumption"])
    for zone in zones_country:
        res = requests.get(
            f"https://api.electricitymap.org/v3/power-breakdown/latest?zone={zone}",
            headers={"auth-token": electricitymap_token},
        ).json()
        production = res.get("powerConsumptionBreakdown")
        if production == None or mix["total_consumption"] == None:
            return False

        # We get mix details
        for keys in production:
            if keys == "nuclear":
                mix["nuclear"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "geothermal":
                mix["geothermal"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "biomass":
                mix["biomass"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "coal":
                mix["coal"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "wind":
                mix["wind"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "solar":
                mix["solar"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "hydro":
                mix["hydro"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "gas":
                mix["gas"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "oil":
                mix["oil"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "unknown":
                mix["unknown"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "hydro discharge":
                mix["hydro discharge"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )
            if keys == "battery discharge":
                mix["battery discharge"] += (
                    production.get(keys) if production.get(keys) is not None else 0
                )

    # We get the top 3 energy sources for the country
    tups = collections.Counter(mix).most_common(4)
    top3 = []
    for tuple in tups:
        if tuple[0] != "total_consumption":
            top3.append(
                tuple + (str(round(tuple[1] / mix["total_consumption"] * 100)),)
            )

    return top3


def send_tweet(
    country1, country2, co2_country1, co2_country2, mix_country1, mix_country2
):
    emoji_list = {
        "Sweden": "\U0001F1F8\U0001F1EA",
        "Portugal": "\U0001F1F5\U0001F1F9",
        "Germany": "\U0001F1E9\U0001F1EA",
        "Greece": "\U0001F1EC\U0001F1F7",
        "Norway": "\U0001F1F3\U0001F1F4",
        "Finland": "\U0001F1EB\U0001F1EE",
        "France": "\U0001F1EB\U0001F1F7",
        "UK": "\U0001F1EC\U0001F1E7",
        "Spain": "\U0001F1EA\U0001F1F8",
        "Italy": "\U0001F1EE\U0001F1F9",
        "Denmark": "\U0001F1E9\U0001F1F0",
        "Hungary": "\U0001F1ED\U0001F1FA",
        "Iceland": "\U0001F1EE\U0001F1F8",
        "Belgium": "\U0001F1E7\U0001F1EA",
        "Netherlands": "\U0001F1F3\U0001F1F1",
        "Ireland": "\U0001F1EE\U0001F1EA",
        "Poland": "\U0001F1F5\U0001F1F1",
        "co2_good": "\U0001F7E2",
        "co2_middle": "\U0001F7E0",
        "co2_bad": "\U0001F534",
    }
    co2_country1_emoji = ""
    co2_country2_emoji = ""
    if 0 <= co2_country1 < 100:
        co2_country1_emoji = emoji_list["co2_good"]
    elif 100 <= co2_country1 < 200:
        co2_country1_emoji = emoji_list["co2_middle"]
    else:
        co2_country1_emoji = emoji_list["co2_bad"]

    if 0 <= co2_country2 < 100:
        co2_country2_emoji = emoji_list["co2_good"]
    elif 100 <= co2_country2 < 200:
        co2_country2_emoji = emoji_list["co2_middle"]
    else:
        co2_country2_emoji = emoji_list["co2_bad"]

    country1_emoji = emoji_list[country1]
    country2_emoji = emoji_list[country2]
    tz = pytz.timezone("Europe/Berlin")
    timestamp_berlin = datetime.datetime.now(tz).strftime("%d/%m/%y %H:%M")
    client.create_tweet(
        text=f"""{country1_emoji} {country1.upper()}: {co2_country1}g CO2/kWh {co2_country1_emoji} using {mix_country1[0][2]}% {mix_country1[0][0].capitalize()}, {mix_country1[1][2]}% {mix_country1[1][0].capitalize()} and {mix_country1[2][2]}% {mix_country1[2][0].capitalize()}
  
{country2_emoji} {country2.upper()}: {co2_country2}g CO2/kWh {co2_country2_emoji} using {mix_country2[0][2]}% {mix_country2[0][0].capitalize()}, {mix_country2[1][2]}% {mix_country2[1][0].capitalize()} and {mix_country2[2][2]}% {mix_country2[2][0].capitalize()}

Provided by @ElectricityMaps, data is about live consumption as of {timestamp_berlin} Berlin's time.
"""
    )


def get_data(division, country1, country2):
    co2_country1 = get_co2(country1)
    co2_country2 = get_co2(country2)
    mix_country1 = get_mix(country1)
    mix_country2 = get_mix(country2)

    if co2_country1 and co2_country2 and mix_country1 and mix_country2:
        print(f"{country1}: CO2 {co2_country1}, mix {mix_country1}")
        print(f"{country2}: CO2 {co2_country2}, mix {mix_country2}")
        cur.execute("select coalesce(max(match_id), 0) from data_fetched")
        match_id = cur.fetchone()[0] + 1
        created_at_utc = datetime.datetime.now(datetime.timezone.utc)
        # We store the result to postgres
        cur.execute(
            "insert into data_fetched (match_id, division, country, co2, mix_1, mix_2, mix_3 \
               , created_at_utc, has_been_tweeted, tweeted_at_utc, mix_1_mwh, mix_2_mwh, mix_3_mwh \
               , mix_1_pct, mix_2_pct, mix_3_pct) \
                VALUES(%s, %s, %s, %s, %s, %s, %s, \
                       %s, %s, %s, %s, %s, %s, \
                       %s, %s, %s)",
            (
                match_id,
                division,
                country1,
                co2_country1,
                mix_country1[0][0],
                mix_country1[1][0],
                mix_country1[2][0],
                created_at_utc,
                False,
                None,
                mix_country1[0][1],
                mix_country1[1][1],
                mix_country1[2][1],
                mix_country1[0][2],
                mix_country1[1][2],
                mix_country1[2][2],
            ),
        )
        cur.execute(
            "insert into data_fetched (match_id, division, country, co2, mix_1, mix_2, mix_3 \
            , created_at_utc, has_been_tweeted, tweeted_at_utc, mix_1_mwh, mix_2_mwh, mix_3_mwh \
            , mix_1_pct, mix_2_pct, mix_3_pct) \
            VALUES(%s, %s, %s, %s, %s, %s, %s, \
                    %s, %s, %s, %s, %s, %s, \
                    %s, %s, %s)",
            (
                match_id,
                division,
                country2,
                co2_country2,
                mix_country2[0][0],
                mix_country2[1][0],
                mix_country2[2][0],
                created_at_utc,
                False,
                None,
                mix_country2[0][1],
                mix_country2[1][1],
                mix_country2[2][1],
                mix_country2[0][2],
                mix_country2[1][2],
                mix_country2[2][2],
            ),
        )
        conn.commit()
        send_tweet(
            country1, country2, co2_country1, co2_country2, mix_country1, mix_country2
        )

    else:
        # it means we have at least 1 country with no value so we roll the matchup again
        get_matchups([division])


get_matchups()
