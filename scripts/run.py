from utils.get_matchup import get_matchup
from utils.get_data import get_data
from utils.send_tweet import send_tweet
import pandas as pd
from os import getcwd

class Comparaison:
    def __init__(self, division):
        self.division = division

    def get_matchup_method(self):
        self.zones = get_matchup(self.division)

    def get_data_method(self):
        self.data = get_data(self.zones)

    def send_tweet_method(self):
        send_tweet(self.data)


if __name__ == "__main__":
    wdb = getcwd()
    df = pd.read_csv(f"{wdb}/utils/zones.csv")
    divisions = pd.unique(df['division'])
    for division in divisions:
        comparaison = Comparaison(division)
        comparaison.get_matchup_method()
        comparaison.get_data_method()
        comparaison.send_tweet_method()