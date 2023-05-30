from typing import Optional
from sqlmodel import Field, SQLModel, create_engine, Session
from enum import Enum



class EntryBase(SQLModel):
    division: str
    country: str
    ts: int
    matchup: int
    co2: int
    way_1: str
    way_1_pc: int
    way_2: str
    way_2_pc: int
    way_3: str
    way_3_pc: int
    tweet_id: str

class Entry(EntryBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)


class EntryCreate(EntryBase):
    pass

class SingleEntry(SQLModel):
    matchup: Optional[int] = Field(default=0)

class EntryRead(SQLModel):
    id: int
    country: str
    ts: str
    matchup: int
    co2: int
    way_1: str
    way_1_pc: int
    way_2: str
    way_2_pc: int
    way_3: str
    way_3_pc: int
    tweet_url: str

    class Config:
        schema_extra = {
            "example": {
                    "id": 3,
                    "country": "FRANCE",
                    "ts": "2023-05-29T18:15:04 UTC",
                    "matchup": 2,
                    "co2": 24,
                    "way_1": "Nuclear",
                    "way_1_pc": 62,
                    "way_2": "Wind",
                    "way_2_pc": 20,
                    "way_3": "Hydro",
                    "way_3_pc": 11,
                    "tweet_url": "https://twitter.com/european_grid/status/1663247598436614158"
            }
        }

class MatchupRead(SQLModel):
    ts: str
    tweet_url: str
    matchup: int
    id_entry_c1: int
    country_1: str
    co2_c1: int
    way_1_c1: str
    way_1_pc_c1: int
    way_2_c1: str
    way_2_pc_c1: int
    way_3_c1: str
    way_3_pc_c1: int   
    id_entry_c2: int
    country_2: str
    co2_c2: int     
    way_1_c2: str
    way_1_pc_c2: int    
    way_2_c2: str
    way_2_pc_c2: int
    way_3_c2: str
    way_3_pc_c2: int
    way_3_c2: str
    way_3_pc_c2: int    

    class Config:
        schema_extra = {
            "example": {
                "ts": "2023-05-29T18:55:42 UTC",
                "tweet_url": "https://twitter.com/european_grid/status/1663257827354214423",
                "matchup": 5,
                "id_entry_c1": 9,
                "country_1": "FRANCE",
                "co2_c1": 24,
                "way_1_c1": "Nuclear",
                "way_1_pc_c1": 62,
                "way_2_c1": "Wind",
                "way_2_pc_c1": 20,
                "way_3_c1": "Hydro",
                "way_3_pc_c1": 11,
                "id_entry_c2": 10,
                "country_2": "GERMANY",
                "co2_c2": 236,
                "way_1_c2": "Wind",
                "way_1_pc_c2": 31,
                "way_2_c2": "Solar",
                "way_2_pc_c2": 31,
                "way_3_c2": "Biomass",
                "way_3_pc_c2": 12
            }
        }

class CountriesIn(str, Enum):
    france = "FRANCE"
    germany = "GERMANY"
    uk = "UK"
    hungary = "HUNGARY"
    danemark = "DANEMARK"
    sweden = "SWEDEN"
    finland = "FINLAND"
    norway = "NORWAY"
    spain = "SPAIN"
    italy = "ITALY"
    greece = "GREECE"
    portugal = "PORTUGAL"

sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"
engine = create_engine(sqlite_url, echo=True)

def get_session():
    with Session(engine) as session:
        yield session

def create_db():
    SQLModel.metadata.create_all(engine)