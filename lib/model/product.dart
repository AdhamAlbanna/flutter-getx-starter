class Product {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0,
    thumbnail: json['thumbnail'] ?? '',
  );
}
