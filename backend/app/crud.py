import os
import uuid
from datetime import datetime, timezone
from sqlalchemy.orm import Session
from google import genai
from google.genai import types
from . import models, schemas

DEFAULT_AI_RESPONSE = {
    "ai_sentiment": "Belirsiz",
    "positivity_score": 50,
    "stress_level": 5,
    "ai_recommendation": "Lumina her zaman yaninda. Bugun kendine kucuk bir iyilik yapmayi unutma.",
    "notification_text": "Bugun nasil hissediyorsun? Kisa bir mola sana cok iyi gelebilir."
}

def create_check_in(db: Session, data: schemas.CheckInCreate, user_email=None):
    ai_data = DEFAULT_AI_RESPONSE.copy()
    try:
        api_key = os.getenv("GEMINI_API_KEY")
        if api_key:
            client = genai.Client(api_key=api_key)
            note_text = data.journal_entry if data.journal_entry else "Kullanici not birakmadi."
            prompt = f"Mood:{data.mood}/5 Enerji:{data.energy}/5 Odak:{data.focus}/5 Not:{note_text} - AIFeedbackResponse JSON uret."
            response = client.models.generate_content(
                model="gemini-2.5-flash",
                contents=prompt,
                config=types.GenerateContentConfig(
                    response_mime_type="application/json",
                    response_schema=schemas.AIFeedbackResponse,
                    temperature=0.7,
                ),
            )
            if response.text:
                parsed = schemas.AIFeedbackResponse.model_validate_json(response.text)
                ai_data = {
                    "ai_sentiment": parsed.detected_emotion,
                    "positivity_score": parsed.positivity_score,
                    "stress_level": parsed.stress_level,
                    "ai_recommendation": parsed.daily_recommendation,
                    "notification_text": parsed.mind_reading_notification_text,
                }
    except Exception as e:
        print(f"YZ Hatasi: {e}")

    user = None
    if user_email:
        user = db.query(models.User).filter(models.User.email == user_email).first()

    row = models.CheckIn(
        id=data.id or f"ci_{uuid.uuid4().hex}",
        timestamp=data.timestamp or datetime.now(timezone.utc),
        mood=data.mood,
        energy=data.energy,
        focus=data.focus,
        emotion_tags=data.emotion_tags,
        journal_entry=data.journal_entry,
        completion_time_seconds=data.completion_time_seconds,
        user_id=user.id if user else None,
        ai_sentiment=ai_data["ai_sentiment"],
        positivity_score=ai_data["positivity_score"],
        stress_level=ai_data["stress_level"],
        ai_recommendation=ai_data["ai_recommendation"],
        notification_text=ai_data["notification_text"],
    )
    db.add(row)
    db.commit()
    db.refresh(row)
    return row

def get_check_in(db: Session, check_in_id: str):
    return db.get(models.CheckIn, check_in_id)

def list_check_ins(db: Session, skip: int = 0, limit: int = 50, user_email=None):
    query = db.query(models.CheckIn)
    if user_email:
        user = db.query(models.User).filter(models.User.email == user_email).first()
        if user:
            query = query.filter(models.CheckIn.user_id == user.id)
    return query.order_by(models.CheckIn.timestamp.desc()).offset(skip).limit(limit).all()

def update_check_in(db: Session, check_in_id: str, data: schemas.CheckInUpdate):
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
