 Lumina - Product Requirements Document (PRD)

Versiyon: MVP v1.0  
Tarih: 15 Nisan 2026  
Hazırlayan: Mükremin Türkmen  


 1. Executive Summary
Lumina, günlük hayatta minimum zaman maliyetiyle maksimum duygusal denge sağlayan, "AI destekli proaktif wellness" uygulamasıdır.  
Kullanıcılar her gün sadece 45 saniyede duygusal durumlarını kaydeder. Lumina zamanla kullanıcıyı tanır ve tam ihtiyacı olan anda **30-90 saniyelik kişiselleştirilmiş mikro destek** sunar.

Tagline: 45 saniyede iç ışığınızı bulun.

 2. Problem Statement
Modern insanlar stres, yorgunluk ve duygusal dalgalanmaları fark etmekte ancak bunları yönetmek için uzun seanslara vakit bulamamaktadır. Mevcut uygulamalar genellikle generic veya zaman alıcıdır.  
Lumina, predictive ve adaptive AI ile ultra kısa etkileşimlerde “beni gerçekten anlıyor” hissini yaratır.

 3. Target Audience & Personas
- Yaş aralığı: 22-40 yaş arası şehirli yetişkinler
- Kişi 1 – Ahmet (28): Beyaz yakalı, yoğun iş temposu, enerji yönetimi sorunu yaşıyor.
- Kişi 2 – Ayşe (34): Freelancer, yaratıcı iş yapıyor, duygusal dalgalanmalar performansını etkiliyor.
- Kişi 3 – Zeynep (22): Üniversite öğrencisi, sınav ve sosyal kaygı karışımı.

4. Product Vision
Her gün birkaç dokunuşla duygusal farkındalığı artırmak ve AI’nin proaktif koçluğuyla hayatın fırtınalarında “iç ışık” bulmayı alışkanlık haline getirmek.

 5. MVP Scope (Prioritized Features)

 P0 – Must Have (Core Loop)
- Onboarding & Authentication (Google, Apple, E-posta)
- Ultra hızlı Daily Check-in (emoji mood + enerji + odak seviyesi + kısa not)
- AI Mikro Koçluk Motoru (30-90 sn kişiselleştirilmiş öneri: nefes egzersizi, CBT reframing, micro-habit)
- Progress Dashboard (renkli mood takvimi, streak sistemi, basit haftalık özet + AI içgörüsü)
- Tam offline destek

 P1 – Should Have
- Akıllı bildirim sistemi (sabah ve akşam)
- Gizlilik odaklı Ayarlar ekranı

 P2 – Post-MVP
- Sesli rehberler, wearable entegrasyonu, detaylı raporlar, topluluk özellikleri

 6. User Flows
1. İlk açılış → Onboarding → İlk check-in
2. Ana ekran → Hızlı check-in → AI önerisi → Uygula veya atla
3. Insights ekranı → Haftalık trend ve içgörüler

 7. Non-Functional Requirements
- Offline-first mimari
- Performans: Check-in < 3 saniye, öneri < 2 saniye
- Gizlilik: Minimum veri toplama, on-device öncelik
- Destek: Android 10+ ve iOS 15+

 8. Technical Stack
- Flutter + Riverpod
- Hive + SQLite (offline)
- AI: Lightweight on-device model + prompt engineering
- Analytics: Firebase (anonim)

 9. Success Metrics
- Day-1 Retention ≥ %65
- Day-7 Retention ≥ %40
- Day-30 Retention ≥ %25
- Ortalama check-in süresi ≤ 55 saniye

 10. Risks & Mitigation
- Risk: Diğer Lumina isimli uygulamalarla karışma → Çözüm: Güçlü farklılaşma (ultra kısa + proaktif AI mikro koçluk)
- Risk: Kullanıcılar check-in’i sıkıcı bulabilir → Çözüm: Haftalık yeni varyasyonlar ve A/B testi
- Risk: AI önerileri yetersiz kalabilir → Çözüm: Erken kullanıcı feedback döngüsü

 11. Roadmap
- v1.0: MVP (P0 + P1)
- v1.1: Ses ve iyileştirmeler
- v2.0: Wearable + ileri AI

Not:Bu PRD, MVP geliştirme sürecinde AI coding araçları (Cursor, Claude, Grok vb.) ile kullanılmak üzere hazırlanmıştır.
