import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/cart_item.dart';

/// Ürün servisi - API'den veri çekme ve sepet yönetimi (Singleton)
class ProductService extends ChangeNotifier {
  // Singleton pattern - tüm ekranlarda aynı instance kullanılır
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  List<Product> _products = [];
  final List<CartItem> _cartItems = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  /// Toplam sepet tutarı
  double get cartTotal =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Sepetteki toplam ürün sayısı
  int get cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  /// Ürünleri yükle - Önce API'den, başarısız olursa lokal JSON'dan
  Future<void> loadProducts() async {
    // Zaten yüklenmişse tekrar yükleme
    if (_products.isNotEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      // 1. Önce API'den veri çekmeyi dene
      _products = await _fetchFromApi();
      debugPrint('✅ Ürünler API\'den yüklendi (${_products.length} ürün)');
    } catch (e) {
      debugPrint('⚠️ API erişilemedi: $e');
      try {
        // 2. API başarısızsa lokal JSON asset'ten oku
        _products = await _loadFromAsset();
        debugPrint('✅ Ürünler lokal JSON\'dan yüklendi (${_products.length} ürün)');
      } catch (e2) {
        debugPrint('❌ Lokal JSON de okunamadı: $e2');
        _products = [];
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  /// API'den ürünleri çek (Fake Store API)
  Future<List<Product>> _fetchFromApi() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products'))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('API yanıt kodu: ${response.statusCode}');
    }
  }

  /// Lokal JSON asset dosyasından ürünleri oku
  Future<List<Product>> _loadFromAsset() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((item) => Product.fromJson(item)).toList();
  }

  /// Sepete ürün ekle
  void addToCart(Product product) {
    final existingIndex =
        _cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  /// Sepetten ürün çıkar
  void removeFromCart(int productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  /// Ürün miktarını artır
  void increaseQuantity(int productId) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  /// Ürün miktarını azalt
  void decreaseQuantity(int productId) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  /// Sepeti temizle
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  /// Kategoriye göre ürün filtreleme
  List<Product> getProductsByCategory(String category) {
    if (category == 'Tümü') return _products;
    return _products.where((p) => p.category == category).toList();
  }

  /// Arama ile ürün filtreleme
  List<Product> searchProducts(String query) {
    if (query.isEmpty) return _products;
    final lowerQuery = query.toLowerCase();
    return _products
        .where((p) =>
            p.title.toLowerCase().contains(lowerQuery) ||
            p.description.toLowerCase().contains(lowerQuery) ||
            p.category.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Benzersiz kategorileri getir
  List<String> get categories {
    final cats = _products.map((p) => p.category).toSet().toList();
    cats.insert(0, 'Tümü');
    return cats;
  }
}
