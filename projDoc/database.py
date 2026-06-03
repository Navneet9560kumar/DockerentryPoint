
import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, DeclarativeBase
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://admin:secret@db:5432/mydatabase")

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(bind=engine)

class Base(DeclarativeBase):
      pass

def get_db():
      db = SessionLocal()
      try:
            yield db
      finally:
            db.close()