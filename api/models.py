from typing import Optional
from sqlmodel import Field, SQLModel, create_engine, Session
from pydantic import condecimal



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

sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"
engine = create_engine(sqlite_url, echo=True)

def get_session():
    with Session(engine) as session:
        yield session

def create_db():
    SQLModel.metadata.create_all(engine)