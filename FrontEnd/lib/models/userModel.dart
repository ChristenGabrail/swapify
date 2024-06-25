import 'package:flutter/cupertino.dart';
/*
class User {
  User({
    required this.UserID,
    required this.Username,
    required this.UserEmail,
    required this.Userphone,
    required this.governorate,
    required this.city,
  });

  String UserID;
  String Username;
  int Userphone;
  String UserEmail;
  String governorate;
  String city;

  factory User.fromJson(dynamic json) {
    return User(
      UserID: json['_id'] as String,
      Userphone: json['phone'] as int,
      UserEmail: json['email'] as String,
      Username: json['username'] as String,
      governorate: json['location']['governorate'] as String,
      city: json['location']['city'] as String,
    );
  }
}
*/

class User {
  String username;
  String email;
  String phone;
  String governorate;
  String city;
  String id;

  //final List<dynamic> favorites; // Adjust the type according to your needs
  final String image;

  User(
      {required this.username,
      required this.email,
      required this.phone,
      required this.governorate,
      required this.city,
      required this.id,
      /*required this.favorites*/
      required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      governorate: json['location']['governorate'],
      city: json['location']['city'],
      id: json['_id'],
      //favorites: json['favorites'],
      image: json['image']['url'] as String,
    );
  }

  /*static User UserFromSnapshot(User snapshot) {
    return User.fromJson();
  }
*/
}
