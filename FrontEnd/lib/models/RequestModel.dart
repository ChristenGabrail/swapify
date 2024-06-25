import 'package:christine_s_application20/models/itemModel.dart';
import 'package:christine_s_application20/models/userModel.dart';

class Request {
  Request(
      {required this.RequestId,
      required this.Item_requested_id,
      required this.Item_offered_id,
      required this.requester_id,
      required this.status,
      this.item1,
      this.item2,
      this.user});

  String RequestId;
  String Item_offered_id;
  String Item_requested_id;
  String requester_id;
  String status;
  Item? item1;
  Item? item2;
  User? user;

  factory Request.fromjson(dynamic json) {
    return Request(
      RequestId: json['_id'] as String,
      Item_offered_id: json['Item_offered_id'] as String,
      Item_requested_id: json['Item_requested_id'] as String,
      requester_id: json['requester_id'] as String,
      status: json['status'] as String,
    );
  }

  static List<Request> RequestsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Request.fromjson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Request {Item_offered_id: $Item_offered_id, id:$RequestId, Item_requested_id:$Item_requested_id, requester_id:$requester_id}';
  }
}
