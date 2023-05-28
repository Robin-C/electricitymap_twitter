from fastapi import Depends, FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy import select, func
from sqlmodel import Session

from models import create_db, add_data, get_session, Entry, SingleEntry, EntryCreate

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
def get_songs(session: Session = Depends(get_session)):
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