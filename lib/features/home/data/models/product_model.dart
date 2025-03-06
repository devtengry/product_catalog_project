class ProductModel {
  final int id;
  final String name;
  final String author;
  final String cover;
  final String description;
  final double price;
  final int sales;
  final String slug;

  ProductModel({
    required this.id,
    required this.name,
    required this.author,
    required this.cover,
    required this.description,
    required this.price,
    required this.sales,
    required this.slug,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      cover: json['cover'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      sales: json['sales'],
      slug: json['slug'],
    );
  }
}
