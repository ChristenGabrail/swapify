import 'categoryModel.dart';

class Item {
  Item({
    required this.ItemID,
    required this.Price,
    required this.Title,
    required this.condition,
    required this.image,
    required this.user_id,
    required this.status,
    required this.CategoryID,
    required this.Description,
  });

  String ItemID;
  String Title;
  int Price;
  bool condition;
  String Description;
  String image;
  String user_id;
  String status;
  String CategoryID;

  factory Item.fromjson(dynamic json) {
    return Item(
      ItemID: json['_id'] as String,
      Title: json['title'] as String,
      Price: json['price'] as int,
      condition: json['condition'] as bool,
      Description: json['Description'],
      image: json['image']['url'] as String,
      user_id: json['user'] as String,
      status: json['status'] as String,
      CategoryID: json['category'] as String,
    );
  }

  static List<Item> itemsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Item.fromjson(data);
    }).toList();
  }

  static List<Item> itemsFromSnapshottt(List<dynamic> snapshot) {
    return snapshot.map((data) {
      return Item.fromjson(Map<String, dynamic>.from(data));
    }).toList();
  }

  @override
  String toString() {
    return 'item {title: $Title, id:$ItemID, price:$Price,image:$image,  condition:$condition, userid:$user_id ,CategoryID:$CategoryID ,  status:$status}';
  }
}
