# 🛍️ Mini Katalog Uygulaması

Flutter ile geliştirilmiş modern bir e-ticaret katalog uygulaması.

## 📱 Proje Hakkında

Mini Katalog, kullanıcıların ürünleri kategorilere göre listeleyebildiği, detaylarını inceleyebildiği ve sepete ekleyebildiği bir mobil e-ticaret uygulamasıdır. Uygulama, yerel JSON veri kaynağı ve Fake Store API entegrasyonu ile çalışmaktadır.

## ✨ Özellikler

- **Ana Sayfa**: Banner, kategori listesi ve hızlı erişim butonları
- **Ürün Listesi**: Grid/Liste görünümü, arama, kategori filtreleme
- **Ürün Detay**: SliverAppBar ile detaylı ürün bilgisi, sepete ekleme
- **Sepet Yönetimi**: Ürün ekleme/çıkarma, miktar kontrolü, toplam fiyat hesaplama
- **API Entegrasyonu**: Yerel JSON + Fake Store API fallback
- **Responsive Tasarım**: Material Design 3 ile modern UI

## 🏗️ Proje Yapısı

```
lib/
├── main.dart                  # Uygulama giriş noktası
├── models/
│   ├── product.dart           # Ürün modeli
│   └── cart_item.dart         # Sepet öğesi modeli
├── services/
│   └── product_service.dart   # Ürün ve sepet servisi (Singleton)
├── screens/
│   ├── home_screen.dart       # Ana sayfa
│   ├── product_list_screen.dart  # Ürün listesi
│   ├── product_detail_screen.dart # Ürün detay
│   └── cart_screen.dart       # Sepet ekranı
├── widgets/
│   └── product_card.dart      # Ürün kartı widget'ı
└── utils/
    ├── routes.dart            # Route yönetimi
    └── constants.dart         # Sabitler
```

## 🛠️ Kullanılan Teknolojiler

- **Flutter** 3.41.1
- **Dart** SDK ^3.11.0
- **http** paketi - API istekleri
- **Material Design 3** - UI tasarım
- **Singleton Pattern** - State yönetimi
- **Named Routes** - Sayfa navigasyonu

## 🚀 Kurulum ve Çalıştırma

```bash
# Repoyu klonla
git clone https://github.com/kkadir8/mini-katalog.git

# Proje dizinine gir
cd mini-katalog

# Bağımlılıkları yükle
flutter pub get

# Uygulamayı çalıştır
flutter run
```

## 📸 Ekran Görüntüleri

| Ana Sayfa | Ürün Listesi | Ürün Detay | Sepet |
|:---------:|:------------:|:----------:|:-----:|
| Kategoriler ve banner | Filtreleme ve arama | Detaylı ürün bilgisi | Sepet yönetimi |

## 👨‍💻 Geliştirici

**Kadir Gedik**

---

> Bu proje, Mobil Programlama dersi kapsamında geliştirilmiştir.
