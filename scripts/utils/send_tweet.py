import datetime
import os
from collections import defaultdict

import pytz
import tweepy

# Twitter set up
access_token_secret = os.getenv("TWEETER_ACCESS_TOKEN_SECRET")
access_token = os.getenv("TWEETER_ACCESS_TOKEN")
consumer_key = os.getenv("TWEETER_CONSUMMER_KEY")
consumer_secret = os.getenv("TWEETER_CONSUMMER_SECRET")


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


def send_tweet(data):
    client = tweepy.Client(
        consumer_key=consumer_key,
        consumer_secret=consumer_secret,
        access_token=access_token,
        access_token_secret=access_token_secret,
    )
    data_tweet = defaultdict(list)
    for country in data:
        country_name = country["country"]
        # Country name
        data_tweet["country_name"].append(country_name)
        # CO2 emoji
        if 0 <= country["co2"] < 100:
            data_tweet["co2_emoji"].append(emoji_list["co2_good"])
        elif 100 <= country["co2"] < 200:
            data_tweet["co2_emoji"].append(emoji_list["co2_middle"])
        else:
            data_tweet["co2_emoji"].append(emoji_list["co2_bad"])
        # CO2 number
        data_tweet["co2_number"].append(country["co2"])
        # Country emoji
        data_tweet["country_emoji"].append(emoji_list[country_name])
        # Top 3 mix
        data_tweet["top3"].append(country["top3"])

    # Write tweet
    tz = pytz.timezone("Europe/Berlin")
    ts = datetime.datetime.now(tz)
    timestamp_berlin = ts.strftime("%d/%m/%y %H:%M")
    ts_unix = int(round(ts.timestamp()))
    country_1 = {
        "country": data_tweet["country_name"][0].upper(),
        "ts": ts_unix,
        "co2": data_tweet["co2_number"][0],
        "way_1": data_tweet["top3"][0][0][0].capitalize(),
        "way_1_pc": data_tweet["top3"][0][0][2],
        "way_2": data_tweet["top3"][0][1][0].capitalize(),
        "way_2_pc": data_tweet["top3"][0][1][2],
        "way_3": data_tweet["top3"][0][2][0].capitalize(),
        "way_3_pc": data_tweet["top3"][0][2][2],
    }
    country_2 = {
        "country": data_tweet["country_name"][1].upper(),
        "ts": ts_unix,
        "co2": data_tweet["co2_number"][1],
        "way_1": data_tweet["top3"][1][0][0].capitalize(),
        "way_1_pc": data_tweet["top3"][1][0][2],
        "way_2": data_tweet["top3"][1][1][0].capitalize(),
        "way_2_pc": data_tweet["top3"][1][1][2],
        "way_3": data_tweet["top3"][1][2][0].capitalize(),
        "way_3_pc": data_tweet["top3"][1][2][2],
    }

    text = f"""{data_tweet['country_emoji'][0]} {data_tweet['country_name'][0].upper()}: {data_tweet['co2_number'][0]}g CO2/kWh {data_tweet['co2_emoji'][0]} \
using {data_tweet['top3'][0][0][2]}% {data_tweet['top3'][0][0][0].capitalize()}, \
{data_tweet['top3'][0][1][2]}% {data_tweet['top3'][0][1][0].capitalize()} \
and {data_tweet['top3'][0][2][2]}% {data_tweet['top3'][0][2][0].capitalize()}.

{data_tweet['country_emoji'][1]} {data_tweet['country_name'][1].upper()}: {data_tweet['co2_number'][1]}g CO2/kWh {data_tweet['co2_emoji'][1]} \
using {data_tweet['top3'][1][0][2]}% {data_tweet['top3'][1][0][0].capitalize()}, \
{data_tweet['top3'][1][1][2]}% {data_tweet['top3'][1][1][0].capitalize()} \
and {data_tweet['top3'][1][2][2]}% {data_tweet['top3'][1][2][0].capitalize()}.

Provided by @ElectricityMaps, data is about live consumption as of {timestamp_berlin} Berlin's time.
"""
    r = client.create_tweet(text=text)
    r = r._asdict()
    country_1["tweet_id"] = r["data"]["id"]
    country_2["tweet_id"] = r["data"]["id"]
    return {"country_1": country_1, "country_2": country_2}
