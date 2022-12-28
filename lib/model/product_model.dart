class ProductModel {
  int? id;
  String? name, category, createdAt, updateAt;

  ProductModel({
    this.id,
    this.name,
    this.category,
    this.createdAt,
    this.updateAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      createdAt: json["created_at"],
      updateAt: json["update_at"],
    );
  }
}
