from fastapi import Depends, FastAPI, Request, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import select, func
from sqlmodel import Session
import ciso8601
import time
from datetime import datetime, time as dttime
from typing import Union, List, Optional

from models import create_db, add_data, get_session, Entry, SingleEntry, EntryCreate, EntryRead

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


create_db()

@app.get("/getlatestmatchup", response_model=SingleEntry)
def get_lastest_matchup_id(session: Session = Depends(get_session)):
    result = session.execute(select(func.max(Entry.matchup))).scalar()
    result = result if result else 0
    print(result)
    return SingleEntry(matchup = result)

@app.post("/entry")
def post_entry(entry: EntryCreate, session: Session = Depends(get_session)):
    new_entry = Entry.from_orm(entry)
    session.add(new_entry)
    session.commit()
    session.refresh(new_entry)
    return entry

@app.get("/pastdata", response_model=List[EntryRead])
def get_past_data(dateFrom: str, dateTo: str, session: Session = Depends(get_session), country: Optional[str] = None):
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