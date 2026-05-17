import uuid
from datetime import datetime, timezone
from sqlalchemy.orm import Session
from . import models, schemas

def create_check_in(db: Session, data: schemas.CheckInCreate) -> models.CheckIn:
    row = models.CheckIn(
        id=data.id or f"ci_{uuid.uuid4().hex}",
        timestamp=data.timestamp or datetime.now(timezone.utc),
        mood=data.mood,
        energy=data.energy,
        focus=data.focus,
        emotion_tags=data.emotion_tags,
        journal_entry=data.journal_entry,
        completion_time_seconds=data.completion_time_seconds,
    )
    db.add(row)
    db.commit()
    db.refresh(row)
    return row

def get_check_in(db: Session, check_in_id: str) -> models.CheckIn | None:
    return db.get(models.CheckIn, check_in_id)

def list_check_ins(db: Session, skip: int = 0, limit: int = 50) -> list[models.CheckIn]:
    return (
        db.query(models.CheckIn)
        .order_by(models.CheckIn.timestamp.desc())
        .offset(skip)
        .limit(limit)
        .all()
    )

def update_check_in(
    db: Session, check_in_id: str, data: schemas.CheckInUpdate
) -> models.CheckIn | None:
    row = get_check_in(db, check_in_id)
    if not row:
        return None
    for field, value in data.model_dump(exclude_unset=True, by_alias=False).items():
        setattr(row, field, value)
    db.commit()
    db.refresh(row)
    return row

def delete_check_in(db: Session, check_in_id: str) -> bool:
    row = get_check_in(db, check_in_id)
    if not row:
        return False
    db.delete(row)
    db.commit()
    return True