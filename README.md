# Lumina

AI-Powered Emotional Balance & Wellness App

> **Tagline:** 45 saniyede iç ışığınızı bulun.

Lumina, günlük hayatın yoğun temposunda duygusal farkındalığınızı artıran, proaktif AI destekli kişisel wellness koçunuzdur. Her gün sadece birkaç dokunuşla ruh halinizi kaydedin; Lumina sizi tanısın ve tam ihtiyacınız olan mikro desteği sunsun.

📋 Proje Dosyaları
* [PRD.md](PRD.md) — Product Requirements Document (MVP v1.0)
* [plan.md](plan.md) — Detaylı Geliştirme Planı

🛠️ Teknik Stack
* **Frontend:** Flutter (Dart)
* **Backend:** Python + FastAPI (Uvicorn)
* **Yapay Zeka (AI):** Google GenAI (Gemini API)
* **Güvenlik & Auth:** OAuth2 (Password Bearer), JWT Token, Bcrypt Hashing
* **Local Storage:** SharedPreferences / Hive

📁 Temel Klasör Yapısı
* `backend/` → Python FastAPI backend servisleri (Auth, Güvenlik, AI Entegrasyonu)
* `lumina_app/` → Flutter mobil & web uygulaması (Clean Architecture / Feature-Based)
  * `lib/features/auth/` → Kayıt Ol ve Giriş Yap ekranları, kurye servisleri (`AuthService`)

🚀 Kurulum ve Çalıştırma (How to Run)

### 1. Backend Kurulumu
`cd backend`
`pip install -r requirements.txt`
`uvicorn app.main:app --reload`

### 2. Frontend Kurulumu
`cd lumina_app`
`flutter pub get`
`flutter run -d web-server --web-port 8080`

Made with focus on mental wellness ✨
