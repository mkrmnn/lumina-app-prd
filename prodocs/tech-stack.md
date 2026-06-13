# Tech Stack — Lumina

## Frontend
- **Flutter (Web)** — Çapraz platform UI framework. Tek kod tabanıyla web/mobil deploy edilebilmesi ve hızlı geliştirme döngüsü için seçildi.
- **http** — Backend API istekleri için.
- **shared_preferences** — JWT token'ın tarayıcıda kalıcı olarak saklanması için.
- **fl_chart** — Mood/Enerji/Odak trend grafiklerini çizmek için. Hafif, özelleştirilebilir ve Flutter ile native entegrasyon sağlıyor.

## Backend
- **FastAPI (Python)** — Hızlı, async destekli, otomatik Swagger dokümantasyonu sunan modern bir API framework'ü. Frontend'den tamamen ayrık, ileride mobil veya başka istemcilere de hizmet verebilecek bir REST API yapısında.
- **SQLAlchemy ORM** — Veritabanı modelleri ve sorgular için.
- **PostgreSQL** — İlişkisel veritabanı; kullanıcı ve check-in verileri arasındaki ilişkiyi (foreign key) doğal olarak destekliyor.
- **python-jose** — JWT token oluşturma ve doğrulama.
- **bcrypt** — Şifre hashleme.
- **Uvicorn** — ASGI sunucu.

## Yapay Zeka Entegrasyonu
- **Google Gemini 2.5 Flash** — Uygulamanın çekirdek mantığına entegre edilmiş AI servisi. Her check-in'de kullanıcının mood/enerji/odak verileri ve günlük notu Gemini'ye gönderiliyor; karşılığında yapılandırılmış JSON formatında (Pydantic schema ile doğrulanmış) duygu analizi, pozitiflik skoru, stres seviyesi ve kişiselleştirilmiş öneri alınıyor.
- **Neden Gemini:** Yapılandırılmış çıktı (structured output / response_schema) desteği, düşük maliyetli flash modeli ve hızlı yanıt süresi nedeniyle seçildi.
- **Graceful Degradation:** Gemini API'ye erişilemediğinde (rate limit, ağ hatası vb.) önceden tanımlanmış varsayılan bir yanıt seti devreye giriyor, kullanıcı deneyimi kesintiye uğramıyor.

## Geliştirme Sürecinde AI Kullanımı
- **Cursor (Composer):** Kod yazımı, dosya düzenleme, hata ayıklama için ana geliştirme ortamı olarak kullanıldı.
- **Claude:** Mimari kararlar (auth flow, token yönetimi, route yapısı), hata teşhisi (örn. AttributeError, 400 Bad Request, yönlendirme sorunları) ve adım adım rehberlik için kullanıldı.
- **Google Gemini API:** Uygulamanın kendisinin çekirdek özelliği olarak entegre edildi (yukarıda açıklandı).

## Deploy
- **Backend:** Render (Docker veya doğrudan Python ortamı)
- **Frontend:** Vercel veya Firebase Hosting (Flutter web build)