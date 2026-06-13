from datetime import datetime
from pydantic import BaseModel, Field, ConfigDict

class CheckInBase(BaseModel):
    mood: int = Field(ge=1, le=5)
    energy: int = Field(ge=1, le=5)
    focus: int = Field(ge=1, le=5)
    emotion_tags: list[str] = Field(default_factory=list, alias="emotionTags")
    journal_entry: str | None = Field(default=None, alias="journalEntry")
    completion_time_seconds: int = Field(default=0, ge=0, alias="completionTimeSeconds")

    model_config = ConfigDict(populate_by_name=True)

class CheckInCreate(CheckInBase):
    id: str | None = None
    timestamp: datetime | None = None

class CheckInUpdate(BaseModel):
    mood: int | None = Field(default=None, ge=1, le=5)
    energy: int | None = Field(default=None, ge=1, le=5)
    focus: int | None = Field(default=None, ge=1, le=5)
    emotion_tags: list[str] | None = Field(default=None, alias="emotionTags")
    journal_entry: str | None = Field(default=None, alias="journalEntry")
    completion_time_seconds: int | None = Field(default=None, ge=0, alias="completionTimeSeconds")

    model_config = ConfigDict(populate_by_name=True)

class CheckInRead(CheckInBase):
    id: str
    timestamp: datetime

    model_config = ConfigDict(from_attributes=True, populate_by_name=True)

class AIFeedbackResponse(BaseModel):
    detected_emotion: str
    positivity_score: int
    stress_level: int
    daily_recommendation: str
    mind_reading_notification_text: str

class UserCreate(BaseModel):
    email: str
    password: str

class UserLogin(BaseModel):
    email: str
    password: str