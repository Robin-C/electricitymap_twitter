import tweepy, os

# Twitter set up
TWEETER_ACCESS_TOKEN_SECRET = os.getenv('TWEETER_ACCESS_TOKEN_SECRET')
TWEETER_ACCESS_TOKEN = os.getenv('TWEETER_ACCESS_TOKEN')
TWEETER_CONSUMMER_KEY = os.getenv('TWEETER_CONSUMMER_KEY')
TWEETER_CONSUMMER_SECRET = os.getenv('TWEETER_CONSUMMER_SECRET')

client = tweepy.Client(
    consumer_key=TWEETER_CONSUMMER_KEY,
    consumer_secret=TWEETER_CONSUMMER_SECRET,
    access_token=TWEETER_ACCESS_TOKEN,
    access_token_secret=TWEETER_ACCESS_TOKEN_SECRET
)

emoji_list = {
    'Sweden': '\U0001F1F8\U0001F1EA',
    'Portugal': '\U0001F1F5\U0001F1F9',
    'Germany': '\U0001F1E9\U0001F1EA',
    'Greece': '\U0001F1EC\U0001F1F7',
    'Norway': '\U0001F1F3\U0001F1F4',
    'Finland': '\U0001F1EB\U0001F1EE',
    'France': '\U0001F1EB\U0001F1F7',
    'UK': '\U0001F1EC\U0001F1E7',
    'Spain': '\U0001F1EA\U0001F1F8',
    'Italy': '\U0001F1EE\U0001F1F9',
    'Denmark': '\U0001F1E9\U0001F1F0',
    'Hungary': '\U0001F1ED\U0001F1FA',
}

def send_tweet(country1, country2):
  country1_emoji = emoji_list[country1]
  country2_emoji = emoji_list[country2]

 
  client.create_tweet(text=f'{country1} {country1_emoji}')



send_tweet('Sweden', 'Sweden')