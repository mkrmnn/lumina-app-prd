# Lumina

AI-Powered Emotional Balance & Wellness App

> **Tagline:** 45 saniyede iç ışığınızı bulun.

 HEAD
Lumina, günlük hayatın yoğun temposunda duygusal farkındalığınızı artıran, proaktif AI destekli kişisel wellness koçunuzdur. Kullanıcılar günlük mood, enerji ve odak seviyelerini kaydeder; Google Gemini AI bu verileri analiz ederek kişiselleştirilmiş geri bildirim ve öneriler sunar.

## 🚀 Canlı Demo

- **Frontend:** (deploy linki buraya eklenecek)
- **Backend API:** (deploy linki buraya eklenecek)

## 🛠 Teknik Stack

- **Frontend:** Flutter (Web)
- **Backend:** Python + FastAPI (Uvicorn)
- **Veritabanı:** PostgreSQL + SQLAlchemy ORM
- **Yapay Zeka:** Google Gemini 2.5 Flash (yapılandırılmış JSON çıktı ile duygu analizi)
- **Güvenlik & Auth:** JWT Token, Bcrypt şifre hashleme

## 📁 Klasör Yapısı

lumina-app-prd/

├── backend/        → Python FastAPI backend servisleri

├── frontend/        → Flutter frontend kodları ve ekranları

├── prodocs/         → Proje dokümantasyonu (PRD, plan, tech-stack, design system, progress)

├── .env.example     → Gerekli environment değişkenlerinin şablonu

└── README.md

## ⚙️ Kurulum

### Backend

```bash
cd backend
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
# .env dosyasını .env.example'a göre oluştur (DATABASE_URL, GEMINI_API_KEY)
uvicorn app.main:app --reload
```

Backend `http://127.0.0.1:8000` adresinde çalışır. Swagger dokümantasyonu: `http://127.0.0.1:8000/docs`

### Frontend

```bash
cd frontend
flutter pub get
flutter run -d chrome
```

## 📄 Dokümantasyon

Detaylı bilgi için `prodocs/` klasörüne bakın:
- `PRD.md` — Ürün gereksinimleri
- `plan.md` — Teknik plan ve user story'ler
- `tech-stack.md` — Teknoloji seçimleri ve gerekçeleri
- `DesignSystem.md` — Renk paleti, tipografi, component kuralları
- `Progress.md` — Geliştirme süreci kaydı

Lumina, günlük hayatın yoğun temposunda duygusal farkındalığınızı artıran, proaktif AI destekli kişisel wellness koçunuzdur.

🛠️ Teknik Stack
* **Frontend:** Flutter (Dart)
* **Backend:** Python + FastAPI (Uvicorn)
* **Yapay Zeka (AI):** Google GenAI (Gemini API)
* **Güvenlik & Auth:** OAuth2, JWT Token, Bcrypt Hashing

📁 Klasör Yapısı
* `backend/` → Python FastAPI backend servisleri
* `lib/` → Flutter frontend kodları ve ekranlar (`features/auth` vb.)
 f8f07a5c42a495a9de385444b6c3107655dbb8a6
