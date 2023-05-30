from fastapi import Depends, FastAPI, HTTPException, Query 
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import select, func
from sqlalchemy.orm import aliased
from sqlmodel import Session
import ciso8601
import time
from datetime import datetime, time as dttime
from typing import Union, List, Optional
from typing_extensions import Annotated

from models import create_db, get_session, Entry, SingleEntry, EntryCreate, EntryRead, MatchupRead, CountriesIn

description = """
This API allows anyone to get data about specific countries or specific matchups:

* **/pastentries** allows you to get information about a specific country (or all countries if left empty)
* **/pastmatchupdetails** allows you to get information about a specific matchup

See documentation below for more information
"""

app = FastAPI(title="Eurogrid Carbon Intensity API",
              description=description,
              version="0.1",
              contact={"name": "Robin CHESNE",
                       "email":"r.chesne@gmail.com"})

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


create_db()

@app.get("/getlatestmatchup", response_model=SingleEntry, include_in_schema=False)
def get_lastest_matchup_id(session: Session = Depends(get_session)):
    result = session.execute(select(func.max(Entry.matchup))).scalar()
    result = result if result else 0
    print(result)
    return SingleEntry(matchup = result)

@app.post("/entry", include_in_schema=False)
def post_entry(entry: EntryCreate, session: Session = Depends(get_session)):
    new_entry = Entry.from_orm(entry)
    session.add(new_entry)
    session.commit()
    session.refresh(new_entry)
    return entry

@app.get("/pastentries", response_model=List[EntryRead])
def get_past_entries(
    dateFrom: str = Query(description="Date to start from using yyyy-mm-dd format", example="2023-01-17")
    , dateTo: str = Query(description="Date to end at using yyyy-mm-dd format", example="2024-01-17")   
    , session: Session = Depends(get_session)
    , country: Optional[CountriesIn] = None):
    # Data validation could be done in a model instead
    try:
        dateFromTs = time.mktime(datetime.combine(ciso8601.parse_datetime(dateFrom).date(), dttime(1,1)).timetuple()) # turn str param into unix ts
        dateToTs = time.mktime(datetime.combine(ciso8601.parse_datetime(dateTo).date(), dttime(23,59)).timetuple())
    except Exception as e:
        print(e)
        raise HTTPException(status_code=422, detail='Bad date format. Try yyyy-mm-dd eg: 2023-05-28')
    if dateFromTs > dateToTs:
        raise HTTPException(status_code=422, detail='dateFrom parameter is superior to dateTo parameter')

    if country:
        results = session.execute(select(
            Entry.id
            , Entry.country
            , Entry.co2
            , Entry.matchup
            , Entry.ts
            , Entry.way_1
            , Entry.way_1_pc
            , Entry.way_2
            , Entry.way_2_pc
            , Entry.way_3
            , Entry.way_3_pc
            , Entry.tweet_id                     
        ).where(Entry.ts >= dateFromTs, Entry.ts <= dateToTs, Entry.country == country)).fetchall()
    else:
        results = session.execute(select(
            Entry.id
            , Entry.country
            , Entry.co2
            , Entry.matchup
            , Entry.ts
            , Entry.way_1
            , Entry.way_1_pc
            , Entry.way_2
            , Entry.way_2_pc
            , Entry.way_3
            , Entry.way_3_pc
            , Entry.tweet_id                    
        ).where(Entry.ts >= dateFromTs, Entry.ts <= dateToTs)).fetchall()
    list = []
    for result in results:
        dictionary = dict(result._mapping)
        # we create tweeter url
        dictionary['tweet_url'] = f"https://twitter.com/european_grid/status/{dictionary['tweet_id']}"
        dictionary.pop('tweet_id')
        # timestamp in human readable form
        dictionary['ts'] = datetime.fromtimestamp(dictionary['ts']).strftime("%Y-%m-%dT%H:%M:%S UTC")
        list.append(EntryRead.parse_obj(dictionary))

    return list

@app.get("/pastmatchupdetails/{country1}/{country2}", response_model=List[MatchupRead])
def get_past_matchups(
      country1: CountriesIn
    , country2: CountriesIn
    , dateFrom: str = Query(description="Date to start from using yyyy-mm-dd format", example="2023-01-17")
    , dateTo: str = Query(description="Date to end at using yyyy-mm-dd format", example="2024-01-17")    
    , session: Session = Depends(get_session)
):

    try:
        dateFromTs = time.mktime(datetime.combine(ciso8601.parse_datetime(dateFrom).date(), dttime(1,1)).timetuple()) # turn str param into unix ts
        dateToTs = time.mktime(datetime.combine(ciso8601.parse_datetime(dateTo).date(), dttime(23,59)).timetuple())
    except Exception as e:
        print(e)
        raise HTTPException(status_code=422, detail='Bad date format. Try yyyy-mm-dd eg: 2023-05-28')
    if dateFromTs > dateToTs:
        raise HTTPException(status_code=422, detail='dateFrom parameter is superior to dateTo parameter')

    country_1_table = aliased(Entry)
    country_2_table = aliased(Entry)
    query = select(country_1_table.ts.label('ts')
                    , country_1_table.tweet_id.label('tweet_id')
                    , country_1_table.matchup.label('matchup')
                    , country_1_table.id.label('id_entry_c1')
                    , country_1_table.country.label('country_1')
                    , country_1_table.co2.label('co2_c1')
                    , country_2_table.id.label('id_entry_c2')
                    , country_2_table.country.label('country_2')
                    , country_2_table.co2.label('co2_c2')                    
                    , country_1_table.way_1.label('way_1_c1')
                    , country_1_table.way_1_pc.label('way_1_pc_c1')
                    , country_2_table.way_1.label('way_1_c2')
                    , country_2_table.way_1_pc.label('way_1_pc_c2')
                    , country_1_table.way_2.label('way_2_c1')
                    , country_1_table.way_2_pc.label('way_2_pc_c1')
                    , country_2_table.way_2.label('way_2_c2')
                    , country_2_table.way_2_pc.label('way_2_pc_c2')
                    , country_1_table.way_3.label('way_3_c1')
                    , country_1_table.way_3_pc.label('way_3_pc_c1')
                    , country_2_table.way_3.label('way_3_c2')
                    , country_2_table.way_3_pc.label('way_3_pc_c2')
                   , country_2_table
                   ).join(country_2_table, country_1_table.matchup == country_2_table.matchup) \
                    .where(country_1_table.country == country1, country_2_table.country == country2) \
                    .where(country_1_table.ts >= dateFromTs, country_1_table.ts <= dateToTs)
    results = session.execute(query)
    list = []
    for r in results:
        dictionary = dict(r._mapping)
        # we create tweeter url
        dictionary['tweet_url'] = f"https://twitter.com/european_grid/status/{dictionary['tweet_id']}"
        dictionary.pop('tweet_id')
        # timestamp in human readable form
        dictionary['ts'] = datetime.fromtimestamp(dictionary['ts']).strftime("%Y-%m-%dT%H:%M:%S UTC")        
        list.append(MatchupRead.parse_obj(dictionary))
    
    if len(list) == 0:
        raise HTTPException(status_code=422, detail="""No result returned. Are you sure both countries are in the same division?
        Read https://github.com/Robin-C/electricitymap_twitter#what-are-divisions for more informations.
        Divisions can be found here https://github.com/Robin-C/electricitymap_twitter/blob/main/scripts/utils/zones.csv"""
                            )

    return list