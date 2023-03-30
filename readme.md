# What does this repo do?

The code tweets every 6 hours [here](https://twitter.com/european_grid) a comparaison for 2 countries of their electricity mix.



# How to run?

To run, you must have an .env file in base directory like this:

```
AUTH_ELECTRICITYMAP=xyz
TWEETER_BEARER_TOKEN=xyz
TWEETER_CONSUMMER_KEY=xyz
TWEETER_CONSUMMER_SECRET=xyz
TWEETER_ACCESS_TOKEN=xyz
TWEETER_ACCESS_TOKEN_SECRET=xyz
```

If you do not have credentials, dm me on [twitter](https://twitter.com/adz122) and I'll help you get set up.

Then you `docker-compose up` and there you go, 3 tweets will be out, 1 per division.

# Steps

3 steps, all of them run synchronously for each division (see below for an explanation of whats a division).

Each step has its own python file 

## get_matchup (get_matchup.py)

This is where countries are picked from within a division. See the "What are divisions" chapter below.

## get_data (get_data.py)

This is where we query electricitymap's api and transform the data a little.

## send_tweet (send_tweet.py)

This is where we create the tweet that will be sent out. Here we transform the data so it is human readable, add emojis, that sort of thing.

# What are divisions

Divisions are sub classes of countries.

For example:


| country | division        |
|---------|-----------------|
| France  | Central Europe  |
| Germany | Central Europe  |
| UK      | Central Europe  |
| Norway  | Northern Europe |
| Sweden  | Northern Europe |
| Finland | Northern Europe |

Everytime the script runs, it will randomly pick 2 countries from each division to go at each other. The draw is probability weighted. All of this happens in the `get_matchup.py` file.