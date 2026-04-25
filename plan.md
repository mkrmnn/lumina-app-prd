 Lumina - Detailed Development Plan (plan.md)

Proje Adı: Lumina  
Tagline: 45 saniyede iç ışığınızı bulun.  
Versiyon: MVP v1.0  
Tarih: 25 Nisan 2026  


 1. Proje Genel Bakışı
Lumina, AI destekli duygusal denge ve wellness uygulamasıdır. Kullanıcı her gün sadece 45 saniyede mood check-in yapar. Uygulama zamanla kullanıcıyı tanır ve proaktif olarak 30-90 saniyelik kişiselleştirilmiş mikro öneriler sunar (nefes egzersizi, düşünce yeniden çerçeveleme, micro-habit vb.).

Bu plan, LLM coding araçlarının (Cursor, Claude, Grok vb.) kolayca takip edip kod üretebileceği şekilde hazırlanmıştır.

 2. Teknik Stack
- Frontend: Flutter (Dart) + Riverpod + GoRouter
- Backend: Node.js + Express.js (REST API)
- Auth & Database: Firebase (Authentication + Firestore) – Backend üzerinden erişilecek
- Local Storage: Hive (offline destek için)
- AI: Başlangıçta on-device lightweight model + prompt engineering
- Dil Desteği: İngilizce + Türkçe (intl paketi ile)

Önemli Kural: Backend ve Frontend **tamamen ayrı dizinlerde** olacak (`frontend/` ve `backend/`).

 3. Repo Klasör Yapısı

lumina-app/
├── frontend/           Flutter uygulaması
├── backend/            Node.js + Express backend
├── docs/
│   └── PRD.md
├── plan.md
├── README.md
├── AGENTS.md         
└── .gitignore


 4. Geliştirme Phase'leri (Adım Adım)

 Phase 0: Proje Kurulumu (İlk Yapılacak)
1. Root klasörde `frontend/` ve `backend/` klasörlerini oluştur
2. `frontend/` içinde yeni Flutter projesi oluştur (`flutter create frontend`)
3. `backend/` içinde Node.js projesi oluştur (`npm init -y` + gerekli paketler)
4. Temel `.gitignore` dosyalarını ekle
5. README.md ve plan.md dosyalarını güncelle

 Phase 1: Backend Temel Altyapı
- Express server kurulumu
- CORS, security middleware (helmet, cors, dotenv)
- Firebase Admin SDK entegrasyonu
- Health check endpoint (`GET /health`)
- Auth middleware (Firebase token doğrulaması)
- Temel route yapısı (`/api/mood`, `/api/ai`)

 Phase 2: Frontend Temel Altyapı
- Flutter projesini yapılandır
- Riverpod + GoRouter kurulumu
- Theme sistemi (light/dark)
- Multilingual support (İngilizce + Türkçe)
- API service katmanı oluşturma
- Feature-first klasör yapısı (`lib/features/auth`, `lib/features/checkin` vb.)

 Phase 3: Authentication
- Backend: Firebase Auth ile login/register endpoint’leri
- Frontend: Google Sign-In, Email/Password ve Apple Sign-In akışları

 Phase 4: Daily Check-in (Core Feature)
- Mood emoji seçici + enerji + odak seviyesi ekranı
- Offline cache ile Hive entegrasyonu
- Backend’e check-in gönderme
- Check-in sonrası AI önerisi gösterme

 Phase 5: AI Mikro Koçluk
- Prompt template’leri
- On-device AI entegrasyonu
- AI öneri endpoint’i
- Kişiselleştirme mantığı (son 7-14 gün verilerine göre)

 Phase 6: Progress & Insights
- Mood takvimi
- Streak sistemi
- Haftalık özet ekranı

 Phase 7: Bildirimler, Ayarlar ve Polish
- Push notifications
- Gizlilik ayarları
- Offline modu iyileştirme
- UI/UX son rötuşlar

 5. Success Criteria (MVP)
- Kullanıcı onboarding + check-in akışı sorunsuz çalışmalı
- Offline modda check-in yapılabilmeli
- AI önerisi hızlı ve ilgili olmalı
- İngilizce ve Türkçe desteklenmeli

 6. Notlar
- Her phase tamamlandığında commit yapılmalı
- Backend ve Frontend iletişimi sadece REST API üzerinden olacak
- Gizlilik ve güvenlik her zaman ön planda tutulacak

Bu plan, PRD.md dosyasındaki MVP kapsamına göre hazırlanmıştır ve sürekli güncellenebilir.
