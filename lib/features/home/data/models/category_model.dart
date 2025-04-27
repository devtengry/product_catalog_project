class CategoryModel {
  List<Category>? category;

  CategoryModel({this.category});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  CategoryFields? fields;

  Category({this.fields});

  Category.fromJson(Map<String, dynamic> json) {
    fields = CategoryFields.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return fields?.toJson() ?? {};
  }
}

class CategoryFields {
  int? id;
  String? name;
  String? createdAt;

  CategoryFields({this.id, this.name, this.createdAt});

  CategoryFields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
    };
  }
}
