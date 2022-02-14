import requests, os, psycopg2, psycopg2.extras

electricitymap_token = os.getenv('AUTH_ELECTRICITYMAP')

# postgres set up
host = 'postgres'
dbname = os.getenv('POSTGRES_DB')
user = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PASSWORD')
conn = psycopg2.connect(f"host={host} dbname={dbname} user={user} password={password}")
cur = conn.cursor()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)


query = cur.execute('select zone_id from public.zone')
zones = cur.fetchall()

for zone in zones:
  co2 = requests.get(f"https://api.electricitymap.org/v3/carbon-intensity/latest?zone={zone[0]}", headers={'auth-token':electricitymap_token})
  print(co2.json())