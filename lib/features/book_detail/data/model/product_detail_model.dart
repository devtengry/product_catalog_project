class ProductDetailModel {
  ProductByPk? productByPk;

  ProductDetailModel({this.productByPk});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    productByPk = json['product_by_pk'] != null
        ? ProductByPk.fromJson(json['product_by_pk'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productByPk != null) {
      data['product_by_pk'] = productByPk!.toJson();
    }
    return data;
  }
}

class ProductByPk {
  String? author;
  int? categoryId;
  String? cover;
  String? description;
  int? id;
  String? name;
  double? price;
  int? sales;
  String? slug;

  ProductByPk(
      {this.author,
      this.categoryId,
      this.cover,
      this.description,
      this.id,
      this.name,
      this.price,
      this.sales,
      this.slug});

  ProductByPk.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    categoryId = json['category_id'];
    cover = json['cover'];
    description = json['description'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    sales = json['sales'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['category_id'] = categoryId;
    data['cover'] = cover;
    data['description'] = description;
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['sales'] = sales;
    data['slug'] = slug;
    return data;
  }
}
