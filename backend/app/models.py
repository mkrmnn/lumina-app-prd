from datetime import datetime
from sqlalchemy import String, Integer, Text, DateTime, ARRAY, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func
from .database import Base

class User(Base):
    __tablename__ = "users"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    email: Mapped[str] = mapped_column(String(100), unique=True, index=True, nullable=False)
    hashed_password: Mapped[str] = mapped_column(String(200), nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), nullable=False)

    check_ins: Mapped[list["CheckIn"]] = relationship(back_populates="user")

class CheckIn(Base):
    __tablename__ = "check_ins"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    timestamp: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    mood: Mapped[int] = mapped_column(Integer, nullable=False)
    energy: Mapped[int] = mapped_column(Integer, nullable=False)
    focus: Mapped[int] = mapped_column(Integer, nullable=False)
    emotion_tags: Mapped[list] = mapped_column(ARRAY(Text), default=list)
    journal_entry: Mapped[str | None] = mapped_column(Text, nullable=True)
    completion_time_seconds: Mapped[int] = mapped_column(Integer, default=0)
    user_id: Mapped[str | None] = mapped_column(String(64), ForeignKey("users.id"), nullable=True)
    user: Mapped["User"] = relationship(back_populates="check_ins")
    ai_sentiment: Mapped[str | None] = mapped_column(String(100), nullable=True)
    positivity_score: Mapped[int | None] = mapped_column(Integer, index=True, nullable=True)
    stress_level: Mapped[int | None] = mapped_column(Integer, index=True, nullable=True)
    ai_recommendation: Mapped[str | None] = mapped_column(Text, nullable=True)
    notification_text: Mapped[str | None] = mapped_column(Text, nullable=True)