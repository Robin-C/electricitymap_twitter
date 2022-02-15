import requests, os, psycopg2, psycopg2.extras, random, itertools

electricitymap_token = os.getenv('AUTH_ELECTRICITYMAP')

res = requests.get(f"https://api.electricitymap.org/v3/power-breakdown/latest?zone=DK-DK1", headers={'auth-token':electricitymap_token}).json()

print(res)