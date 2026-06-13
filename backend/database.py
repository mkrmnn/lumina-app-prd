import os
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from sqlmodel import SQLModel

# .env dosyasından veya sistemden veritabanı URL'ini al, yoksa yerel SQLite kullan
DATABASE_URL = os.environ.get("DATABASE_URL", "sqlite+aiosqlite:///./lumina.db")

# Veritabanı motorunu oluşturuyoruz
engine = create_async_engine(DATABASE_URL, echo=True, future=True)

# Veritabanı oturumu (Session) fabrikası
async_session = sessionmaker(
    engine, class_=AsyncSession, expire_on_commit=False
)

# Tabloları otomatik oluşturmak için yardımcı fonksiyon
async def init_db():
    async with engine.begin() as conn:
        # Kod tabanlı oluşturma (Alembic öncesi hızlı test için)
        await conn.run_sync(SQLModel.metadata.create_all)

# FastAPI endpoint'lerinde DB oturumu sağlamak için Dependency Injection
async def get_session() -> AsyncSession:
    async with async_session() as session:
        yield session
