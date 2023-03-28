from os import getcwd

import pandas as pd
import numpy as np

wdb = getcwd()
zones_df = pd.read_csv(f"{wdb}/utils/zones.csv")
probabilities_df = pd.read_csv(f"{wdb}/utils/probabilities.csv")


def get_matchup(division):
    # we filter based on division
    zones_filtered = zones_df.loc[zones_df["division"] == division]

    # add probabilities
    zones_filtered = zones_filtered.merge(probabilities_df, on="country", how="left")
    countries = pd.unique(zones_filtered["country"])
    probabilities_filtered = probabilities_df[
        probabilities_df["country"].isin(countries)
    ]
    p = probabilities_filtered["p"].tolist()
    # draw 2 countries
    choices = np.random.choice(countries, size=2, replace=False, p=p)
    # return zones of selected countries
    zones = zones_filtered[zones_filtered["country"].isin(choices)]
    return zones
