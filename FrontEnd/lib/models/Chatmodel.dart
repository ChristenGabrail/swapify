import 'package:christine_s_application20/models/userModel.dart';

class Chat {
  Chat(
      {required this.chatId,
      required this.userId,
      required this.username,
      this.lastMessText,
      required this.Time,
      this.userInfo,
      required this.date,
      this.photo});

  String chatId;
  String username;
  String userId;
  String? lastMessText;
  String? photo;
  String Time;
  User? userInfo;
  DateTime date;

  factory Chat.fromjson(dynamic json) {
    return Chat(
      chatId: json['chatId'] as String,
      username: json['users'][0]['username'] as String,
      userId: json['users'][0]['userId'] as String,
      lastMessText: json['lastMessage']['text'] != null
          ? json['lastMessage']['text'] as String?
          : null,
      photo: json['lastMessage']['photo'] != null
          ? json['lastMessage']['photo']['url'] as String?
          : null,
      Time: json['lastMessage']['time'] as String,
      date: DateTime.parse(json['lastMessage']['date']),
    );
  }

  static List<Chat> ChatsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Chat.fromjson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Chat {username: $username, id:$chatId, userId:$userId, lastMessText:$lastMessText}';
  }
}
