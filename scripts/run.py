import pandas as pd
import os
from os import getcwd
import requests
import time
from utils.get_matchup import get_matchup
from utils.get_data import get_data
from utils.send_tweet import send_tweet

SAVE_TWEETS = os.environ.get('SAVE_TWEETS', False)
API_IP = os.environ.get('API_IP', None)
API_PORT = os.environ.get('API_PORT', None)

class Comparaison:
    def __init__(self, division):
        self.division = division
        self.url = f"http://{API_IP}:{API_PORT}"
        self.lastest_endpoint = "/getlatestmatchup"
        self.post = "/entry"

    def get_matchup_method(self):
        self.zones = get_matchup(self.division)

    def get_data_method(self):
        self.data = get_data(self.zones)

    def send_tweet_method(self):
        self.payload = send_tweet(self.data)

    def save_entry(self):
        lastest_matchup_url = self.url + self.lastest_endpoint
        lastest_matchup = requests.get(url=lastest_matchup_url).json().get('matchup', 0)
        post_url = self.url + self.post
        for country_index, data in self.payload.items():
            payload = {
                "division": self.division
                , "country": data.get('country')
                , "ts": int(data.get('ts'))
                , "matchup": lastest_matchup + 1
                , "co2": int(data.get('co2'))
                , "way_1": data.get('way_1')
                , "way_1_pc": int(data.get('way_1_pc'))
                , "way_2": data.get('way_2')
                , "way_2_pc": data.get('way_2_pc')
                , "way_3": data.get('way_3')
                , "way_3_pc": data.get('way_3_pc')
                , "tweet_id": data.get('tweet_id')                            
            }
            requests.post(url=post_url, json=payload, headers={"Content-Type":"application/json"})

if __name__ == "__main__":
    wdb = getcwd()
    df = pd.read_csv(f"{wdb}/scripts/utils/zones.csv")
    divisions = pd.unique(df['division'])
    for division in divisions:
        comparaison = Comparaison(division)
        comparaison.get_matchup_method()
        comparaison.get_data_method()
        comparaison.send_tweet_method()
        if SAVE_TWEETS:
            comparaison.save_entry()