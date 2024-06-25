// models/recommendation_model.dart

class Recommendation {
  final String id;
  final String title;
  final String Description;
  final String categoryID;
  final bool condition;
  final String imageUrl;
  final int price;
  final String status;
  final String user_id;

  Recommendation(
      {required this.id,
      required this.title,
      required this.Description,
      required this.categoryID,
      required this.condition,
      required this.imageUrl,
      required this.price,
      required this.status,
      required this.user_id});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
        id: json['_id']['\$oid'],
        title: json['title'],
        Description: json['Description'],
        categoryID: json['category']['\$oid'],
        condition: json['condition'],
        imageUrl: json['image']['url'],
        price: json['price'],
        status: json['status'],
        user_id: json['user']['\$oid']);
  }
}
