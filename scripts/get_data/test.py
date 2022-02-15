import requests, os, psycopg2, psycopg2.extras, random, itertools

electricitymap_token = os.getenv('AUTH_ELECTRICITYMAP')

# postgres set up
host = 'postgres'
dbname = os.getenv('POSTGRES_DB')
user = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PASSWORD')
conn = psycopg2.connect(f"host={host} dbname={dbname} user={user} password={password}")
cur = conn.cursor()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

qry = cur.execute("select zone_id from public.zone where country = 'Danemark'")
res = cur.fetchall()

res_unnested = list(itertools.chain.from_iterable(res))

print(res_unnested)