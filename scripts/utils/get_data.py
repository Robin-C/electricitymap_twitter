import os
import requests
import pandas as pd

electricitymap_token = os.getenv('AUTH_ELECTRICITYMAP')

def get_data(zones):
    data = []
    countries = pd.unique(zones['country'])
    for country in countries:
        zones_of_country = zones[zones['country'] == country]
        ids = pd.unique(zones_of_country['zone_id'])
        # CO2
        country_co2_levels_raw = []
        country_consumption_total = []
        country_co2_levels_cleaned = []
        for id in ids:
            res = requests.get(f"https://api.electricitymap.org/v3/power-breakdown/latest?zone={id}", headers={'auth-token':electricitymap_token}).json()
            country_consumption_total.append(sum(res.get('powerConsumptionBreakdown').values()))
            co2 = requests.get(f"https://api.electricitymap.org/v3/carbon-intensity/latest?zone={id}", headers={'auth-token':electricitymap_token}).json()
            country_co2_levels_raw.append(co2.get('carbonIntensity'))
        
        for co2_level, production_level in zip(country_co2_levels_raw, country_consumption_total):
            country_co2_levels_cleaned.append(co2_level*production_level)
        co2 = round(sum(country_co2_levels_cleaned) / sum(country_consumption_total))
        data.append({"country": country, "co2": co2})
    print(data)
    return data