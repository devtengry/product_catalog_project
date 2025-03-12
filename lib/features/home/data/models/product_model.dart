class Product {
  final int id;
  final String name;
  final double price;
  final String cover;
  final String author;
  final String description;
  final int likes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.cover,
    required this.author,
    required this.description,
    required this.likes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'] as double,
      cover: json['cover'],
      author: json['author'],
      description: json['description'],
      likes: json['likes_aggregate']['aggregate']['count'] ?? 0,
    );
  }
}
