import tweepy, os, psycopg2, psycopg2.extras, itertools, numpy as np


# postgres set up
host = 'postgres'
dbname = os.getenv('POSTGRES_DB')
user = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PASSWORD')
conn = psycopg2.connect(f"host={host} dbname={dbname} user={user} password={password}")
cur = conn.cursor()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)



def get_matchups(divisions = 'all'):
  
  # We query the divisions
  if divisions == 'all':
    cur.execute('select division from public.zone group by 1')
    divisions = cur.fetchall()
    divisions = list(itertools.chain.from_iterable(divisions))
  
  for division in divisions:
    division
    cur.execute('select country, probability from public.zone where division = %s group by 1, 2', (division,))
    countries = cur.fetchall()

    country_list = [country[0] for country in countries]
    probability_list = [round(float(country[1]), 3) for country in countries]

    choices = np.random.choice(country_list, size=2, replace=False, p=probability_list)
    country1 = choices[0]
    countr2 = choices[1]
    # print(f"country1: {country_list[choices[0]]}")

    # winners = random.sample(range(0, runners), 2)
    # country1 = countries[winners[0]]
    # country2 = countries[winners[1]]
    #get_data(division, country1, country2)

get_matchups()