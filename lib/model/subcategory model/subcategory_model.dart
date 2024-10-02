class SubCategoryModel {
  int id;
  int categoryId;
  String name;
  String image;

  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "image": image,
      };
}
