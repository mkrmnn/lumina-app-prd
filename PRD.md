 Lumina - Product Requirements Document (PRD)

Versiyon: MVP v1.0  
Tarih: 15 Nisan 2026  
Hazırlayan: Mükremin Türkmen 


 1. Executive Summary
Lumina, modern hayatın kaosunda kullanıcılara "45 saniyede iç ışığını bulma" imkanı sunan, AI destekli proaktif duygusal denge uygulamasıdır.  
Kullanıcı günlük check-in yaparak duygusal durumunu kaydeder; Lumina zamanla öğrenir ve kişiselleştirilmiş mikro müdahaleler önerir.

Tagline: 45 saniyede iç ışığınızı bulun.

 2. Problem Statement
İnsanlar stres ve duygusal dalgalanmaları fark etmekte ancak uzun meditasyon veya karmaşık araçlara vakit ayıramamaktadır. Lumina, ultra kısa ve akıllı etkileşimlerle gerçek değer yaratır.

 3. Target Audience
- 22-40 yaş arası şehirli çalışanlar, freelancer’lar ve öğrenciler
- Yoğun tempo nedeniyle zamanı sınırlı olanlar
- Mental wellness’e ilgi duyan ama uzun seans istemeyenler

 4. MVP Özellikleri

 P0 – Must Have
- Kolay onboarding (Google, Apple, E-posta)
- Ultra hızlı Daily Check-in (mood emoji + enerji + odak seviyesi + kısa not)
- AI Mikro Koçluk (30-90 saniye kişiselleştirilmiş öneriler)
- Progress Dashboard (mood takvimi, streak, haftalık AI içgörüsü)
- Tam offline destek

 P1 – Should Have
- Akıllı bildirimler
- Gizlilik & Ayarlar ekranı

 P2 – Future
- Sesli rehberler
- Wearable entegrasyonu
- Detaylı raporlar

 5. Multilingual Support (Dil Desteği)
- MVP’de dahil edilecek diller:İngilizce + Türkçe
- Uygulama arayüzü, AI önerileri ve bildirimler her iki dilde de desteklenecek.
- Dil seçimi onboarding sırasında yapılacak.
- Yapı: Flutter Internationalization kullanılarak hazırlandı. İleride İspanyolca, Almanca vb. kolayca eklenebilir.

 6. Non-Functional Requirements
- Offline-first
- Yüksek performans (check-in < 3 sn)
- Gizlilik odaklı (çoğu veri cihazda kalacak)
- Destek: Android 10+ ve iOS 15+

 7. Technical Stack
- Flutter + Riverpod
- Hive + SQLite
- AI: Lightweight on-device model
- Analytics: Firebase (anonim)

 8. Success Metrics
- Day-1 Retention ≥ %65
- Day-7 Retention ≥ %40
- Day-30 Retention ≥ %25

 9. Risks & Mitigation
- Rekabet (benzer isimler) → Güçlü farklılaşma ile proaktif AI vurgusu
- Düşük retention → Kısa ve eğlenceli check-in + streak sistemi

##- v1.0 MVP (İngilizce + Türkçe)
- v1.1 Ses ve iyileştirmeler
- v2.0 Daha fazla dil + Wearable

Bu PRD, MVP geliştirme için AI araçlarıyla hazırlanmıştır.
