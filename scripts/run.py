from utils.get_matchup import get_matchup
from utils.get_data import get_data

class Comparaison():
    def __init__(self, division):
        self.division = division
    
    def get_matchup_method(self):
        self.zones = get_matchup(self.division)

    def get_data_method(self):
        get_data(self.zones)

    def send_tweet_method(self):
        print('ok')


if __name__ == "__main__":
    test = Comparaison('Northern Europe')
    test.get_matchup_method()
    test.get_data_method()
