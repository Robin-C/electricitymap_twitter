import requests, os

electricitymap_token = os.getenv('AUTH_ELECTRICITYMAP')

def get_mix():
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

  res = requests.get(f"https://api.electricitymap.org/v3/power-breakdown/latest?zone=DE", headers={'auth-token':electricitymap_token}).json()
  print(res)
  print('----')
  res2 = requests.get(f"https://api.electricitymap.org/v3/carbon-intensity/latest?zone=DE", headers={'auth-token':electricitymap_token}).json()
  print(res2)

get_mix()