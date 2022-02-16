import requests, os, psycopg2, psycopg2.extras, random, itertools, collections, datetime

electricitymap_token = os.getenv('AUTH_ELECTRICITYMAP')

# postgres set up
host = 'postgres'
dbname = os.getenv('POSTGRES_DB')
user = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PASSWORD')
conn = psycopg2.connect(f"host={host} dbname={dbname} user={user} password={password}")
cur = conn.cursor()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)


# query = cur.execute('select zone_id from public.zone')
# zones = cur.fetchall()

# First we decide on matchups
# Every tweet opposes 2 countries. Countries are split in division (northern europe, southern europe, central europe). A country can only fight against a country of the same division.
matchup = []
zone_ids = []

def get_matchups(divisions = 'all'):
  # We query the divisions
  if divisions == 'all':
    query = cur.execute('select division from public.zone group by 1')
    divisions = cur.fetchall()

  for division in divisions:
    division = division[0]
    cur.execute('select country from public.zone where division = %s group by 1', (division,))
    countries = cur.fetchall()
    countries = list(itertools.chain.from_iterable(countries))
    print(division)
    print(countries)
    print(len(countries))
    runners = len(countries)
    winners = random.sample(range(0, runners), 2)
    country1 = countries[winners[0]]
    country2 = countries[winners[1]]
    get_data(division, country1, country2)

def get_zones(country):
   # First we get the zones for each country
   query = cur.execute("select zone_id from public.zone where country = %s ", (country,))
   zones_country = cur.fetchall()
   zones_country = list(itertools.chain.from_iterable(zones_country))
   return zones_country

def get_co2(country, division):
   zones_country = get_zones(country)
   country_co2_levels_raw = []
   country_co2_levels_cleaned = []
   country_production_levels = []

   for zone in zones_country:
     co2 = requests.get(f"https://api.electricitymap.org/v3/carbon-intensity/latest?zone={zone}", headers={'auth-token':electricitymap_token}).json()
     country_co2_levels_raw.append(co2.get('carbonIntensity'))
     if country_co2_levels_raw == None:
       get_matchups(division)
       return False
     production = requests.get(f"https://api.electricitymap.org/v3/power-breakdown/latest?zone={zone}", headers={'auth-token':electricitymap_token}).json()
     if production.get('error'):
       get_matchups(division)
       return False
     country_production_levels.append(production.get('powerProductionTotal'))

   for co2_level, production_level in zip(country_co2_levels_raw, country_production_levels):
      country_co2_levels_cleaned.append(co2_level*production_level)

   co2 = round(sum(country_co2_levels_cleaned) / sum(country_production_levels))
   return co2

def get_mix(country, division):
  zones_country = get_zones(country)
  mix = {
  'nuclear': 0,
  'geothermal': 0,
  'biomass': 0,
  'coal': 0,
  'wind': 0,
  'solar': 0,
  'hydro': 0,
  'gas': 0,
  'oil': 0,
  'unknown': 0,
  'hydro_discharge': 0,
  'battery_discharge': 0,
  'total_production': 0
  }

  for zone in zones_country:
    res = requests.get(f"https://api.electricitymap.org/v3/power-breakdown/latest?zone={zone}", headers={'auth-token':electricitymap_token}).json()
    production = res.get('powerProductionBreakdown')
    if production == None:
      get_matchups(division)
      return False
    mix['total_production'] += res.get('powerProductionTotal')

   # We get mix details
    for keys in production:
        if keys == 'nuclear':
          mix['nuclear'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'geothermal':
          mix['geothermal'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'biomass':
          mix['biomass'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'coal':
          mix['coal'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'wind':
          mix['wind'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'solar':
          mix['solar'] += production.get(keys) if production.get(keys) is not None else 0                           
        if keys == 'hydro':
          mix['hydro'] += production.get(keys) if production.get(keys) is not None else 0 
        if keys == 'gas':
          mix['gas'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'oil':
          mix['oil'] += production.get(keys) if production.get(keys) is not None else 0 
        if keys == 'unknown':
          mix['unknown'] += production.get(keys) if production.get(keys) is not None else 0                                                                            
        if keys == 'hydro discharge':
          mix['hydro_discharge'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'battery discharge':
          mix['battery_discharge'] += production.get(keys) if production.get(keys) is not None else 0    

  # We get the top 3 energy source for the country
  tups = collections.Counter(mix).most_common(4)
  top3 = []
  for tuple in tups:
    if tuple[0] != 'total_production':
      top3.append(tuple + (str(round(tuple[1] / mix['total_production']*100)),))

  return top3

def get_data(division, country1, country2):
  co2_country1 = get_co2(country1, division)
  co2_country2 = get_co2(country2, division)
  mix_country1 = get_mix(country1, division)
  mix_country2 = get_mix(country2, division)
  if co2_country1 and co2_country2 and mix_country1 and mix_country2:
    print(f'{country1}: CO2 {co2_country1}, mix {mix_country1}')
    print(f'{country2}: CO2 {co2_country2}, mix {mix_country2}')
    cur.execute("select coalesce(max(match_id), 0) from data_fetched")
    match_id = cur.fetchone()[0] + 1
    created_at_utc = datetime.datetime.now(datetime.timezone.utc)
    # We store the result to postgres
    cur.execute("insert into data_fetched (match_id, division, country, co2, mix_1, mix_2, mix_3 \
               , created_at_utc, has_been_tweeted, tweeted_at_utc, mix_1_mwh, mix_2_mwh, mix_3_mwh \
               , mix_1_pct, mix_2_pct, mix_3_pct) \
                VALUES(%s, %s, %s, %s, %s, %s, %s, \
                       %s, %s, %s, %s, %s, %s, \
                       %s, %s, %s)", \
                ( \
                  match_id, division, country1, co2_country1, mix_country1[0][0], mix_country1[1][0], mix_country1[2][0], \
                 created_at_utc, False, None,  mix_country1[0][1], mix_country1[1][1], mix_country1[2][1], \
                 mix_country1[0][2], mix_country1[1][2], mix_country1[2][2]
                )
               )
    cur.execute("insert into data_fetched (match_id, division, country, co2, mix_1, mix_2, mix_3 \
            , created_at_utc, has_been_tweeted, tweeted_at_utc, mix_1_mwh, mix_2_mwh, mix_3_mwh \
            , mix_1_pct, mix_2_pct, mix_3_pct) \
            VALUES(%s, %s, %s, %s, %s, %s, %s, \
                    %s, %s, %s, %s, %s, %s, \
                    %s, %s, %s)", \
            ( \
              match_id, division, country2, co2_country2, mix_country2[0][0], mix_country2[1][0], mix_country2[2][0], \
              created_at_utc, False, None,  mix_country2[0][1], mix_country2[1][1], mix_country2[2][1], \
              mix_country2[0][2], mix_country2[1][2], mix_country2[2][2]
            )
            )
    conn.commit()
    # We generate tweet


get_matchups()