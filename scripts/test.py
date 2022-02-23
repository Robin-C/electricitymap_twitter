import tweepy, os, psycopg2, psycopg2.extras, itertools, numpy as np, requests, datetime
import matplotlib.pyplot as plt
import matplotlib.animation as animation

electricitymap_token = os.getenv('AUTH_ELECTRICITYMAP')

# postgres set up
host = 'postgres'
dbname = os.getenv('POSTGRES_DB')
user = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PASSWORD')
conn = psycopg2.connect(f"host={host} dbname={dbname} user={user} password={password}")
cur = conn.cursor()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)



co2_history_country1 = requests.get(f"https://api.electricitymap.org/v3/carbon-intensity/history?zone=DE", headers={'auth-token':electricitymap_token}).json()
co2_history_country2 = requests.get(f"https://api.electricitymap.org/v3/carbon-intensity/history?zone=FR", headers={'auth-token':electricitymap_token}).json()


country1_data = []
def get_dt(str):
    dt = datetime.datetime.strptime(str, '%Y-%m-%dT%H:%M:%S.%fZ')
    return dt

for datapoint in co2_history_country1['history']:
    country1_data.append({
        'updated_at_dt': get_dt(datapoint.get('createdAt')),
        'co2': datapoint.get('carbonIntensity')
    })

data_lst = [point.get('co2') for point in country1_data if point.get('co2') != None]
# create the figure and axis objects
fig, ax = plt.subplots()

ax.plot(data_lst)
ax.set_xlabel('Day Number')
ax.set_ylabel('Temperature (*F)')
ax.set_title('Temperature in Portland, OR over 7 days')

fig.savefig('static_plot.png')
plt.show()