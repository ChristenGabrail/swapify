class Message {
  Message({required this.sender, this.text, required this.date, this.photo});

  String sender;
  String? photo; // Allowing photo to be null
  String? text;
  DateTime date;

  factory Message.fromjson(dynamic json) {
    return Message(
      sender: json['sender'].toString(), // Ensure sender is a String
      photo: json['photo'] != null ? json['photo']['url'] as String? : null,
      text: json['text'] != null ? json['text'] as String : '',
      date: DateTime.parse(json['date']),
    );
  }

  static List<Message> MessagesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Message.fromjson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Message { Sender id:$sender, text:$text, photo:$photo, date:$date}';
  }
}
