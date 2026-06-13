# Progress.md — Lumina Geliştirme Günlüğü

## Genel Durum
Lumina, kullanıcıların günlük duygu durumlarını (mood, enerji, odak) kaydettiği ve Google Gemini AI ile kişiselleştirilmiş geri bildirim aldığı bir wellness check-in uygulamasıdır.

## Tamamlanan Özellikler

### Backend (FastAPI + PostgreSQL)
- JWT tabanlı kullanıcı kayıt/giriş sistemi (bcrypt ile şifre hashleme)
- `/api/v1/auth/register` ve `/api/v1/auth/login` endpoint'leri
- `/api/v1/check-ins` CRUD endpoint'leri (POST, GET, PATCH, DELETE)
- Tüm check-in endpoint'leri Bearer token ile korunuyor — her kullanıcı sadece kendi verisini görebiliyor
- Google Gemini API entegrasyonu: her check-in'de yapılandırılmış JSON çıktısı (duygu analizi, pozitiflik skoru, stres seviyesi, günlük öneri, bildirim metni)
- Graceful Degradation: Gemini API'ye ulaşılamazsa (503, ağ hatası vb.) varsayılan bir yanıt seti devreye giriyor, uygulama çökmüyor
- SQLAlchemy ORM ile User ve CheckIn modelleri, ilişkisel veri yapısı

### Frontend (Flutter Web)
- Giriş/Kayıt ekranı (LoginScreen) — tek ekranda mod değişimi
- Başarılı girişte JWT token'ı SharedPreferences'a kaydetme
- Token decode edilerek kullanıcı email'i dashboard'da gösteriliyor
- Check-in ekranı: mood (emoji seçici), enerji ve odak slider'ları, not alanı
- Tüm API istekleri Authorization: Bearer header'ı ile gönderiliyor
- Dashboard ekranı: toplam kayıt sayısı, haftalık mood özeti, "Lumina Koçun" AI önerisi kartı
- İstatistikler ekranı: fl_chart ile Mood/Enerji/Odak trend grafikleri (son 7 kayıt), ortalama istatistik kartları, son kayıtlar listesi
- Alt navigasyon: Ana Sayfa, Check-in, İstatistikler

## Çözülen Önemli Hatalar
- `AttributeError: module 'app.security' has no attribute 'create_access_token'` — security.py'de eksik JWT fonksiyonu eklendi
- Duplicate security.py dosyaları (root ve app/ klasöründe) — root'taki silindi
- Login başarılı olduğunda HomeScreen'e yönlendirme yapılmıyordu — named routes ve WidgetsBinding.addPostFrameCallback ile çözüldü
- Check-in ve istatistik endpoint'leri tüm kullanıcıların verisini gösteriyordu — JWT token'dan email çıkarılıp veriler kullanıcıya göre filtrelendi

## Devam Eden / Planlanan
- Production deploy: Backend → Render, Frontend → Vercel/Firebase Hosting
- .env.example, tech-stack.md, DesignSystem.md dosyalarının eklenmesi
- Demo video kaydı

## Kullanılan AI Araçları
- Cursor (Composer) ile kod yazımı ve hata ayıklama
- Claude ile mimari kararlar, hata teşhisi ve adım adım rehberlik
- Google Gemini 2.5 Flash ile uygulama içi duygu analizi (çekirdek özellik)