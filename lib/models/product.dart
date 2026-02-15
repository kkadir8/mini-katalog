/// Ürün modeli - JSON verisinden Dart nesnesine dönüşüm
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
  });

  /// JSON'dan Product nesnesine dönüşüm
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      rating: json['rating'] is double
          ? json['rating']
          : json['rating'] is Map
              ? double.tryParse(json['rating']['rate'].toString()) ?? 0.0
              : double.tryParse(json['rating'].toString()) ?? 0.0,
    );
  }

  /// Product nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'rating': rating,
    };
  }
}
