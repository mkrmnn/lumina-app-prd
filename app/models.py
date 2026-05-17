from datetime import datetime
from sqlalchemy import String, Integer, Text, DateTime, ARRAY
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy.sql import func
from .database import Base

class CheckIn(Base):
    __tablename__ = "check_ins"

    id: Mapped[str] = mapped_column(String(64), primary_key=True)
    timestamp: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), nullable=False
    )
    mood: Mapped[int] = mapped_column(Integer, nullable=False)
    energy: Mapped[int] = mapped_column(Integer, nullable=False)
    focus: Mapped[int] = mapped_column(Integer, nullable=False)
    emotion_tags: Mapped[list] = mapped_column(ARRAY(Text), default=list)
    journal_entry: Mapped[str | None] = mapped_column(Text, nullable=True)
    completion_time_seconds: Mapped[int] = mapped_column(Integer, default=0)