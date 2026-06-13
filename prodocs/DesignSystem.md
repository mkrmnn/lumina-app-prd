# Design System — Lumina

## Renk Paleti

Uygulama, sakin ve pozitif bir wellness deneyimi sunmak için açık tonlu, mor ağırlıklı bir palet kullanıyor.

| Renk | Kullanım Alanı |
|------|----------------|
| **Primary (Purple)** | Ana aksiyon butonları, seçili öğeler, grafik vurguları |
| **Deep Purple** | Gradient'lerin koyu tonu, başlık vurguları |
| **Lilac** | İkon arka planları, hafif vurgu kutuları |
| **Background** | Genel sayfa arka planı (açık gri/beyaz) |
| **Surface** | Kart arka planları (beyaz) |
| **Border** | Kart ve input kenarlıkları (açık gri) |
| **Text Secondary** | İkincil metinler, hint'ler, etiketler |

Mood/İstatistik grafiklerinde anlamlandırma için ek renkler:
- **Mood (Turuncu)** — Duygu durumu trendini temsil eder
- **Enerji (Amber/Sarı)** — Enerji seviyesini temsil eder
- **Odak (Mavi)** — Odaklanma seviyesini temsil eder

## Tipografi

| Stil | Kullanım |
|------|----------|
| **Screen Title** | Sayfa başlıkları (örn. "Hoş geldin", "Analizler") — büyük, kalın |
| **Section Title** | Kart başlıkları (örn. "Haftalık Mood Özeti", "Lumina Koçun") — orta boy, kalın |
| **Body** | Genel metin içerikleri |
| **Hint** | Placeholder, açıklama, ikincil bilgi metinleri — küçük, soluk renk |
| **Button** | Buton içi metinler — kalın, beyaz |

## Component Kuralları

### Kartlar (Cards)
- Köşe yuvarlaklığı: 14–18px
- Arka plan: Surface rengi
- Kenarlık: Border rengi, 1px
- İç boşluk (padding): 14–20px

### Butonlar
- Yükseklik: 50–52px
- Köşe yuvarlaklığı: 12–14px
- Arka plan: Primary
- Yazı rengi: Beyaz, kalın

### Giriş Alanları (TextField)
- Dolgu rengi: White12 / Surface
- Köşe yuvarlaklığı: 12px
- Kenarlık yok (filled stil), focus durumunda Primary renk kenarlık

### Navigasyon
- Alt navigasyon barı: 3 sekme (Ana Sayfa, Check-in, İstatistikler)
- Aktif sekme: Primary renk ile vurgulanır

### Grafikler (fl_chart)
- Çizgi grafik (LineChart), yumuşak eğri (isCurved: true)
- Alan dolgusu: çizgi rengi %15 opaklıkta
- Grid çizgileri: yatay, ince, Border rengi
- Y ekseni aralığı: 0–6 (mood/enerji/odak skalası 1–5 olduğu için)

## Genel Prensipler
- Sade, fazla görsel gürültüden uzak arayüz
- Pozitif ve destekleyici dil (örn. "Harika gidiyorsun!")
- AI çıktıları (Lumina Koçun) görsel olarak ayrıştırılmış bir kart içinde, ikonla desteklenmiş şekilde sunulur