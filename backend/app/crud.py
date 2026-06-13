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
    "ai_recommendation": "Şu an zihnini okurken küçük bir bağlantı sorunu yaşıyorum ama Lumina her zaman yanında. Bugün kendine küçük bir iyilik yapmayı unutma.",
    "notification_text": "Bugün nasıl hissediyorsun? Kısa bir mola sana çok iyi gelebilir."
}

def create_check_in(db: Session, data: schemas.CheckInCreate, user_email: str | None = None) -> models.CheckIn:
    ai_data = DEFAULT_AI_RESPONSE.copy()

    try:
        api_key = os.getenv("GEMINI_API_KEY")
        if api_key:
            client = genai.Client(api_key=api_key)
            note_text = data.journal_entry if data.journal_entry else "Kullanıcı bugün herhangi bir not bırakmadı."
            prompt = f"""
            Sen profesyonel, empatik bir psikolojik iyi oluş asistanisin.
            Kullanicinin bugünkü verileri:
            - Duygu Durumu (Mood): {data.mood}/5
            - Enerji Seviyesi: {data.energy}/5
            - Odaklanma Seviyesi: {data.focus}/5
            - Günlük Notu: "{note_text}"
            Bu verileri analiz et ve AIFeedbackResponse JSON semasina uygun bir cevap üret.
            """
            response = client.models.generate_content(
                model='gemini-2.5-flash',
                contents=prompt,
                config=types.GenerateContentConfig(
                    response_mime_type="application/json",
                    response_schema=schemas.AIFeedbackResponse,
                    temperature=0.7,
                ),
            )
            if response.text:
                parsed_data = schemas.AIFeedbackResponse.model_validate_json(response.text)
                ai_data = {
                    "ai_sentiment": parsed_data.detected_emotion,
                    "positivity_score": parsed_data.positivity_score,
                    "stress_level": parsed_data.stress_level,
                    "ai_recommendation": parsed_data.daily_recommendation,
                    "notification_text": parsed_data.mind_reading_notification_text
                }
    except Exception as e:
        print(f"YZ Motoru Hatası: {e}")

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
        notification_text=ai_data["notification_text"]
    )
    db.add(row)
    db.commit()
    db.refresh(row)
    return row

def get_check_in(db: Session, check_in_id: str) -> models.CheckIn | None:
    return db.get(models.CheckIn, check_in_id)

def list_check_ins(db: Session, skip: int = 0, limit: int = 50, user_email: str | None = None) -> list[models.CheckIn]:
    query = db.query(models.CheckIn)
    if user_email:
        user = db.query(models.User).filter(models.User.email == user_email).first()
        if user:
            query = query.filter(models.CheckIn.user_id == user.id)
    return query.order_by(models.CheckIn.timestamp.desc()).offset(skip).limit(limit).all()

def update_check_in(db: Session, check_in_id: str, data: schemas.CheckInUpdate) -> models.CheckIn | None:
    row = get_check_in(db, check_in_id)
    if not row:
        return None
    for