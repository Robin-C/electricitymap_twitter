from asyncio.windows_events import NULL
import requests, os, psycopg2, psycopg2.extras, random, itertools

# postgres set up
host = 'postgres'
dbname = os.getenv('POSTGRES_DB')
user = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PASSWORD')
conn = psycopg2.connect(f"host={host} dbname={dbname} user={user} password={password}")
cur = conn.cursor()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

cur.execute("create table if not exists data_fetched (\
 ID  int NOT NULL AUTO_INCREMENT, \
 match_id int NOT NULL, \
 division text, \
country text, \
co2 int, \
mix_1 text, \
mix_2 text, \
mix_3 text, \
created_at_utc timestamp, \
has_been_tweeted boolean, \
tweeted_at_utc timestamp, \
)")
