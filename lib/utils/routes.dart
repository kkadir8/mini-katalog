import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/product_list_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';

/// Named Routes tanımlamaları
class AppRoutes {
  static const String home = '/';
  static const String productList = '/products';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';

  /// Route oluşturucu - Named Routes için
  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => const HomeScreen(),
      cart: (context) => const CartScreen(),
    };
  }

  /// Route arguments ile sayfa geçişleri için onGenerateRoute
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>? ?? {};
    switch (settings.name) {
      case productList:
        return MaterialPageRoute(
          builder: (context) => ProductListScreen(
            initialCategory: args['category'] as String? ?? 'Tümü',
          ),
        );
      case productDetail:
        return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            productId: args['productId'] as int,
          ),
        );
      default:
        return null;
    }
  }
}
