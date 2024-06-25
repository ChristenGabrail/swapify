class CategoryModel {
  CategoryModel({
    required this.CategoryModelID,
    required this.Name,
    required this.image,
  });

  String CategoryModelID;
  String Name;
  String image;

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      CategoryModelID: json['_id'] as String,
      Name: json['name'] as String,
      image: json['image']['url'] as String,
    );
  }

  static List<CategoryModel> categoriessFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return CategoryModel.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'item {Name: $Name, id:$CategoryModelID, image:$image}';
  }

  fromJson(Map<String, dynamic> json) {}
}
