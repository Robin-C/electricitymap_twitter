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
    way_1_pc: condecimal(max_digits=5, decimal_places=2) = Field(default=0)
    way_2: str
    way_2_pc: condecimal(max_digits=5, decimal_places=2) = Field(default=0)
    way_3: str
    way_3_pc: int

class Entry(EntryBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)

class EntryCreate(EntryBase):
    pass

class SingleEntry(SQLModel):
    matchup: Optional[int] = Field(default=0)
  

sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"
engine = create_engine(sqlite_url, echo=True)

def get_session():
    with Session(engine) as session:
        yield session

def create_db():
    SQLModel.metadata.create_all(engine)

def add_data():
    test = Entry(division='Europe'
                               , country='test'
                               , ts=10101
                               , matchup=5
                               , co2 = 100
                               , way_1 = 'djsk'
                               , way_1_pc = 0.35
                               , way_2 = "djd"
                               , way_2_pc = 0.35
                               , way_3 = "lkjdsq"
                               , way_3_pc = 0.45
                               )
    engine = create_engine(sqlite_url, echo=True)
    session = Session(engine)
    session.add(test)
    session.commit()