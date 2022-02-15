import requests, os, psycopg2, psycopg2.extras, random, itertools, collections

electricitymap_token = os.getenv('AUTH_ELECTRICITYMAP')

# postgres set up
host = 'postgres'
dbname = os.getenv('POSTGRES_DB')
user = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PASSWORD')
conn = psycopg2.connect(f"host={host} dbname={dbname} user={user} password={password}")
cur = conn.cursor()
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)


# query = cur.execute('select zone_id from public.zone')
# zones = cur.fetchall()

# First we decide on matchups
# Every tweet opposes 2 countries. Countries are split in division (northern europe, southern europe, central europe). A country can only fight against a country of the same division.
matchup = []
zone_ids = []

def get_matchup():
  # We query the divisions
  query = cur.execute('select division from public.zone group by 1')
  divisions = cur.fetchall()
  for division in divisions:
    query = cur.execute('select country from public.zone where division = %s group by 1', (division[0],))
    countries = cur.fetchall()
    countries = list(itertools.chain.from_iterable(countries))
    runners = len(countries)
    winners = random.sample(range(0, runners), 2)
    # Finally we get the zone_id for each country
    print(countries)
    query = cur.execute("select zone_id from public.zone where country = %s or country = %s", (countries[winners[0]],countries[winners[1]]))
    zones = cur.fetchall()
    # Unnest the query result
    zones = list(itertools.chain.from_iterable(zones))
    zone_ids.append(zones)

def get_zones(country):
   # First we get the zones for each country
   query = cur.execute("select zone_id from public.zone where country = %s ", (country,))
   zones_country = cur.fetchall()
   zones_country = list(itertools.chain.from_iterable(zones_country))
   return zones_country

def get_co2(country):
   zones_country = get_zones(country)
   country_co2 = {'country': country}
   country_co2_levels_raw = []
   country_co2_levels_cleaned = []
   country_production_levels = []

   for zone in zones_country:
     co2 = requests.get(f"https://api.electricitymap.org/v3/carbon-intensity/latest?zone={zone}", headers={'auth-token':electricitymap_token}).json()
     country_co2_levels_raw.append(co2.get('carbonIntensity'))
     production = requests.get(f"https://api.electricitymap.org/v3/power-breakdown/latest?zone={zone}", headers={'auth-token':electricitymap_token}).json()
     country_production_levels.append(production.get('powerProductionTotal'))

   for co2_level, production_level in zip(country_co2_levels_raw, country_production_levels):
      country_co2_levels_cleaned.append(co2_level*production_level)

   co2 = round(sum(country_co2_levels_cleaned) / sum(country_production_levels))
   return co2

def get_mix(country):
  zones_country = get_zones(country)
  mix = {
  'nuclear': 0,
  'geothermal': 0,
  'biomass': 0,
  'coal': 0,
  'wind': 0,
  'solar': 0,
  'hydro': 0,
  'gas': 0,
  'oil': 0,
  'unknown': 0,
  'hydro_discharge': 0,
  'battery_discharge': 0,
  'total_production': 0
  }

  for zone in zones_country:
    res = requests.get(f"https://api.electricitymap.org/v3/power-breakdown/latest?zone={zone}", headers={'auth-token':electricitymap_token}).json()
    production = res.get('powerProductionBreakdown')
    mix['total_production'] += res.get('powerProductionTotal')

   # We get mix details
    for keys in production:
        if keys == 'nuclear':
          mix['nuclear'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'geothermal':
          mix['geothermal'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'biomass':
          mix['biomass'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'coal':
          mix['coal'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'wind':
          mix['wind'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'solar':
          mix['solar'] += production.get(keys) if production.get(keys) is not None else 0                           
        if keys == 'hydro':
          mix['hydro'] += production.get(keys) if production.get(keys) is not None else 0 
        if keys == 'gas':
          mix['gas'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'oil':
          mix['oil'] += production.get(keys) if production.get(keys) is not None else 0 
        if keys == 'unknown':
          mix['unknown'] += production.get(keys) if production.get(keys) is not None else 0                                                                            
        if keys == 'hydro discharge':
          mix['hydro_discharge'] += production.get(keys) if production.get(keys) is not None else 0
        if keys == 'battery discharge':
          mix['battery_discharge'] += production.get(keys) if production.get(keys) is not None else 0    

  # We get the top 3 energy source for the country
  tups = collections.Counter(mix).most_common(4)
  top3 = []
  for tuple in tups:
    if tuple[0] != 'total_production':
      top3.append(tuple + (str(round(tuple[1] / mix['total_production']*100, 2)) + '%',))
  print(top3)

def get_data(matchup, country1, country2):
  get_co2(country1)
  get_co2(country2)
  get_mix(country2)





# get_matchup()
print(get_data('central', 'Danemark', 'France'))
