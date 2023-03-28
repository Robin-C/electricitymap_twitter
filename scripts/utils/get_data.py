import os
import collections
import requests
import pandas as pd

electricitymap_token = os.getenv("AUTH_ELECTRICITYMAP")


def get_data(zones):
    data = []
    countries = pd.unique(zones["country"])
    for country in countries:
        zones_of_country = zones[zones["country"] == country]
        ids = pd.unique(zones_of_country["zone_id"])
        country_co2_levels_raw = []
        country_consumption_total = []
        country_co2_levels_cleaned = []
        mix = {}
        # CO2
        for id in ids:
            res = requests.get(
                f"https://api.electricitymap.org/v3/power-breakdown/latest?zone={id}",
                headers={"auth-token": electricitymap_token},
            ).json()
            country_consumption_total.append(
                sum(res.get("powerConsumptionBreakdown").values())
            )
            co2 = requests.get(
                f"https://api.electricitymap.org/v3/carbon-intensity/latest?zone={id}",
                headers={"auth-token": electricitymap_token},
            ).json()
            country_co2_levels_raw.append(co2.get("carbonIntensity"))
            # Mix
            mix_res = requests.get(
                f"https://api.electricitymap.org/v3/power-breakdown/latest?zone={id}",
                headers={"auth-token": electricitymap_token},
            ).json()
            production = mix_res.get("powerConsumptionBreakdown")
            for key, value in production.items():
                mix[key] = mix.get(key, 0) + value
        # Top 3 mix
        tuples = collections.Counter(mix).most_common(3)
        top3 = []
        for tuple in tuples:
            top3.append(
                tuple + (str(round(tuple[1] / sum(country_consumption_total) * 100)),)
            )
        for co2_level, production_level in zip(
            country_co2_levels_raw, country_consumption_total
        ):
            country_co2_levels_cleaned.append(co2_level * production_level)
        co2 = round(sum(country_co2_levels_cleaned) / sum(country_consumption_total))
        data.append({"country": country, "co2": co2, "mix": mix, "top3": top3})
    return data
