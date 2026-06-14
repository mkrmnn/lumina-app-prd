from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import engine, Base
from app.routers import checkins, auth
from sqlalchemy import text

Base.metadata.create_all(bind=engine)

# Manuel migration - eksik kolonları ekle
def run_migrations():
    with engine.connect() as conn:
        migrations = [
            "ALTER TABLE check_ins ADD COLUMN IF NOT EXISTS user_id VARCHAR(64)",
            "ALTER TABLE check_ins ADD COLUMN IF NOT EXISTS ai_sentiment VARCHAR(100)",
            "ALTER TABLE check_ins ADD COLUMN IF NOT EXISTS positivity_score INTEGER",
            "ALTER TABLE check_ins ADD COLUMN IF NOT EXISTS stress_level INTEGER",
            "ALTER TABLE check_ins ADD COLUMN IF NOT EXISTS ai_recommendation TEXT",
            "ALTER TABLE check_ins ADD COLUMN IF NOT EXISTS notification_text TEXT",
            "CREATE TABLE IF NOT EXISTS users (id VARCHAR(64) PRIMARY KEY, email VARCHAR(100) UNIQUE NOT NULL, hashed_password VARCHAR(200) NOT NULL, created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW())",
        ]
        for migration in migrations:
            try:
                conn.execute(text(migration))
            except Exception as e:
                print(f"Migration hatası (devam ediliyor): {e}")
        conn.commit()

run_migrations()

app = FastAPI(title="Lumina API", version="0.1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(checkins.router, prefix="/api/v1")
app.include_router(auth.router, prefix="/api/v1")

@app.get("/health")
def health():
    return {"status": "ok"}