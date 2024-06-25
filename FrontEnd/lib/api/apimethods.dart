import 'dart:convert';
import 'dart:io';
import 'package:christine_s_application20/models/MessageModel.dart';
import 'package:christine_s_application20/models/RequestModel.dart';
import 'package:christine_s_application20/presentation/profile_screen/profile_screen.dart';
import 'package:christine_s_application20/presentation/published_page/published_page.dart';
import 'package:christine_s_application20/presentation/registration_successful_screen/registration_successful_screen.dart';
import 'package:christine_s_application20/presentation/requests_tab_container_screen/requests_tab_container_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../models/Chatmodel.dart';
import '../models/categoryModel.dart';
import '../models/itemModel.dart';
import '../models/recommendation_model.dart';
import '../models/userModel.dart';
import '../navbar/NavMenu.dart';
import '../presentation/sign_up_upload_photo_one_screen/sign_up_upload_photo_one_screen.dart';
import 'SharedPrefes.dart';
import 'apiendpoints.dart';
import 'package:http/http.dart' as http;

class ApisMethods {
  String? token = sharedPreferences.getString('token');

// set for fav ids bta3t el items
  static Set<String> favoritesID = {};

//1- login api
  static Future<void> login(emailController, passwordController) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.authEndPoint.loginEmail);
    if (emailController.isNotEmpty && passwordController.isNotEmpty) {
      http.Response response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': emailController.trim(),
            'password': passwordController
          }));
      print('apiiii ${emailController} + ${passwordController} ');
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPrefes.SaveToken(json['token']);
        Get.off(NAVmenu());
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Error'),
                contentPadding: EdgeInsets.all(20),
                children: [Text(json['message'])],
              );
            });
      }
    } else {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('black field not allowed')],
            );
          });
    }
  }

//2- rigister api
  static Future<void> register(
      emailController,
      passwordController,
      userNameController,
      phoneNumberController,
      cityController,
      governoratevalueController) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.authEndPoint.registerEmail);
    if (emailController.isNotEmpty &&
        passwordController.isNotEmpty &&
        userNameController.isNotEmpty &&
        phoneNumberController.isNotEmpty &&
        cityController.isNotEmpty &&
        governoratevalueController.isNotEmpty) {
      var jsonBody = jsonEncode({
        'username': userNameController,
        'password': passwordController,
        'email': emailController,
        'phone': phoneNumberController,
        'governorate': governoratevalueController,
        'city': cityController
      });
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: jsonBody);
      final json = jsonDecode(response.body);
      if (response.statusCode == 201) {
        SharedPrefes.SaveToken(json['token']);
        Get.off(SignUpUploadPhotoOneScreen());
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              print(json['message']);
              return SimpleDialog(
                title: Text('Error'),
                contentPadding: EdgeInsets.all(20),
                children: [Text(json['message'])],
              );
            });
      }
    } else {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('black field not allowed')],
            );
          });
    }
  }

//3- getitems api
  static Future<List<Item>> getitems(String token) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.itemEdPoint.getitem);
    final Response = await http.get(url, headers: {'token': token});
    var data = jsonDecode(Response.body);
    List _temp = [];
    print('apiiii ${Response.body}');

    for (var i in data['data']) {
      _temp.add(i);
    }

    return Item.itemsFromSnapshot(_temp);
  }

//4- getitem by  item id api
  static Future<Item> getitembyID(String id) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.itemEdPoint.grtitembyID +
        id);
    final Response = await http.get(url);

    if (Response.statusCode == 200) {
      return Item.fromjson(json.decode(Response.body)['data']);
    } else {
      throw Exception('Failed to load item');
    }
  }

//5- getuserinfo api
  static Future<User> getuserinfo(String? token) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.userEndPoint.UserInfo);
    final Response = await http.get(url, headers: {'token': "$token"});
    Map data = jsonDecode(Response.body);

    print('${data['data']}');
    return User.fromJson(data['data']);
  }

//6- updateuser api
  static Future<void> updateUserInfo(String token, String userNameController,
      String email, String phone, String city, String governorate) async {
    final url = Uri.parse(
        '${ApiEndPoints.baseUrl.trim() + ApiEndPoints.userEndPoint.userUpdate}'); // Adjust if your endpoint URL differs
    final headers = {
      'Content-Type': 'application/json',
      'token': token, // Assuming your server expects the token in the header
    };
    final body = jsonEncode({
      'username': userNameController,
      'email': email,
      'phone': phone,
      'city': city,
      'governorate': governorate,
    });

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Parse the JSON response if it's successful
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Success'),
                contentPadding: EdgeInsets.all(20),
                children: [Text(' update user info successfully')],
              );
            });
        print('update user info  successfully ${response.body}');
        Get.off(NAVmenu());
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Error'),
                contentPadding: EdgeInsets.all(20),
                children: [
                  Text(' failed to update user info: ${response.body}')
                ],
              );
            });
        // Handle errors or unsuccessful responses
      }
    } catch (e) {
      // Handle any exceptions/errors
      print('Error: $e');
    }
  }

//7- getAllCategories list
  static Future<List<CategoryModel>> getAllCategories() async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.categoryEndpoint.getcategory);
    final Response = await http.get(url);
    var data = jsonDecode(Response.body);
    List tempList = [];
    if (Response.statusCode == 200) {
      for (var index in data) {
        tempList.add(index);
      }
    } else {}
    return CategoryModel.categoriessFromSnapshot(tempList);
  }

//8- uploadUserPhoto
  static Future<void> uploaduserphoto(String token, File image) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.userEndPoint.userPhoto);
    var request = http.MultipartRequest("POST", url)
      ..headers['token'] = token
      ..files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
      ));

    var response = await request.send();
    if (response.statusCode == 200) {
      Get.off(RegistrationSuccessfulScreen());
    } else {
      print('image upload faild ');
    }
  }

//9- getitems for one user api
  static Future<List<Item>> getitemsforoneuser(String? token) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.requestsEndPoint.getlistitemforoneuser);
    final Response = await http.get(url, headers: {'token': "$token"});
    var data = jsonDecode(Response.body);
    List _temp = [];

    for (var i in data) {
      _temp.add(i);
    }
    print(_temp);
    return Item.itemsFromSnapshot(_temp);
  }

//10- send request
  static Future<void> request(
      String itemRequestID, String itemExchangeID, String? token) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.requestsEndPoint.sendRequest);
    var jsonBody = jsonEncode({
      'Item_offered_id': "${itemExchangeID}",
      'Item_requested_id': "${itemRequestID}"
    });
    if (itemRequestID.isNotEmpty && itemExchangeID.isNotEmpty) {
      print(itemRequestID);
      print(itemExchangeID);
      var response = await http.post(url,
          body: jsonBody,
          headers: {'Content-Type': 'application/json', 'token': "$token"});
      if (response.statusCode == 200) {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Success'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('request sent successfully')],
              );
            });
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('error'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('${jsonDecode(response.body)}')],
              );
            });
        print('request faild ${jsonDecode(response.body)}');
      }
    } else {
      print('empty fileds');
    }
  }

// 11- change password
  static Future<void> changePassword(
      String token, String oldPassword, String newPassword) async {
    final url = Uri.parse(
        '${ApiEndPoints.baseUrl.trim() + ApiEndPoints.userEndPoint.changePass}'); // Adjust if your endpoint URL differs
    final headers = {
      'Content-Type': 'application/json',
      'token': token, // Assuming your server expects the token in the header
    };
    final body = jsonEncode({
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('success'),
                contentPadding: EdgeInsets.all(20),
                children: [Text(' ${jsonDecode(response.body)['msg']}')],
              );
            });
        Get.off(ProfileScreen());
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Error'),
                contentPadding: EdgeInsets.all(20),
                children: [Text(' ${jsonDecode(response.body)['msg']}')],
              );
            });
      }
    } catch (e) {
      // Handle any exceptions/errors
      print('Error: $e');
    }
  }

//12- getChats api
  static Future<List<Chat>> getChats(String token) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.chatsEndPoint.getAllChat);
    var Response = await http.get(url, headers: {'token': "$token"});

    if (Response.statusCode == 200) {
      List data = jsonDecode(Response.body)['chats'];
      print('chatsssssssssss ${data}');
      return Chat.ChatsFromSnapshot(data);
    } else {
      // Log error or handle it appropriately
      print('Request failed with status: ${Response.statusCode}.');
      throw Exception('Failed to load chats');
    }
  }

//13- getALLmessages api
  static Future<List<Message>> getMessages(
      String SenderID, String ReciverID) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.chatsEndPoint.getAllMess +
        '/' +
        SenderID +
        '/' +
        ReciverID);
    var Response = await http.get(url);

    if (Response.statusCode == 200) {
      var jsonResponse = jsonDecode(Response.body);
      if (jsonResponse.isEmpty || jsonResponse[0]['messages'].isEmpty) {
        // Return an empty list if no messages are found
        return [];
      }
      List data = jsonDecode(Response.body)[0]['messages'];
      return Message.MessagesFromSnapshot(data);
    } else {
      // Log error or handle it appropriately
      print('Request failed with status: ${Response.statusCode}.');
      throw Exception('Failed to load chats');
    }
  }

//14-send message
  static Future<void> sendMessage(
      String receiverId, String message, String? token) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.chatsEndPoint.sendMess);
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!, // Authorization token (JWT)
        },
        body: jsonEncode(<String, String>{
          'Receiver_id': receiverId,
          'Message': message,
        }),
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
        print(json.decode(response.body)); // Print the response from the server
      } else {
        print('Failed to send message: ${response.statusCode}');
        print(
            json.decode(response.body)); // Print error response from the server
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

//15- get user info for item api
  static Future<User> getuserinfoForItem(String userID) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.userEndPoint.userinfoByid +
        userID);
    final Response = await http.get(url);
    Map data = jsonDecode(Response.body);
    return User.fromJson(data['data']);
  }

//16- create item
  static Future<void> createItem(
      String token,
      String titleController,
      bool conditionController,
      String priceController,
      File? fileImageController,
      String descriptionController,
      String categoryController) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.itemEdPoint.createItem);

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll({'token': ' $token'});

    if (titleController.isNotEmpty &&
        priceController.isNotEmpty &&
        descriptionController.isNotEmpty &&
        categoryController.isNotEmpty &&
        fileImageController != null) {
      request.fields['title'] = titleController;
      request.fields['Description'] = descriptionController;
      request.fields['price'] = priceController;
      request.fields['category'] = categoryController;
      request.fields['condition'] = conditionController.toString();

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        fileImageController.path,
      ));

      try {
        var response = await request.send();
        if (response.statusCode == 201) {
          String responseBody = await response.stream.bytesToString();
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: Text('Success'),
                  contentPadding: EdgeInsets.all(20),
                  children: [Text('Item Added Successfully')],
                );
              });
          Get.off(NAVmenu());
        } else {
          String errorResponse = await response.stream.bytesToString();
          print('Error: ${response.statusCode} - $errorResponse');
        }
      } catch (e) {
        print('Error sending data: $e');
      }
    } else {
      // Improved error handling logic or UI feedback
      print('One or more fields are empty, or image file is missing.');
    }
  }

//17-get Fav items api
  static Future<List<Item>> getFAV(String token) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.itemEdPoint.getFav);
    final Response = await http.get(url, headers: {
      'token': token,
    });
    List _temp = [];
    if (Response.statusCode == 200) {
      Map data = jsonDecode(Response.body);
      if (data['data'] != null) {
        for (var i in data['data']) {
          _temp.add(i);
          favoritesID.add((i)['_id'].toString());
        }
      }
    }

    print(_temp);

    return Item.itemsFromSnapshot(_temp);
  }

//18- delete item
  static Future<void> deleteItem(String token, String itemID) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.itemEdPoint.deleteItem +
        itemID);
    final Response = await http.delete(url, headers: {
      'token': token,
    });
    if (Response.statusCode == 200) {
      print('Item deleted successfully');
      Get.off(PublishedPage());
    } else {
      // Error handling
      var decodedResponse = jsonDecode(Response.body) as Map<String, dynamic>;
      print('Failed to delete item: ${decodedResponse['msg']}');
    }
  }

//19- update item api
  static Future<void> updateItem(
    String token,
    String price,
    String title,
    String fileIamge,
    String Description,
    bool condition,
    String category,
    String itemID,
  ) async {
    final url = Uri.parse(
        '${ApiEndPoints.baseUrl.trim() + ApiEndPoints.itemEdPoint.updateItem + itemID}'); // Adjust if your endpoint URL differs
    final headers = {
      'Content-Type': 'application/json',
      'token': token, // Assuming your server expects the token in the header
    };
    final body = jsonEncode({
      'price': price,
      'title': title,
      'image': fileIamge,
      'Description': Description,
      'condition': condition,
      'category': category
    });

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Parse the JSON response if it's successful
        print(json.decode(response.body));
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: Text('Success'),
                contentPadding: EdgeInsets.all(20),
                children: [Text('item update successfully')],
              );
            });
        print('item update successfully ${response.body}');
        Get.off(NAVmenu());
      } else {
        // Handle errors or unsuccessful responses
        print('Failed to update item ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions/errors
      print('Error: $e');
    }
  }

//20- add to saved items
  static Future<void> AddtoSaved(String? token, String itemID) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.itemEdPoint.addTOsaved +
        itemID);
    final Response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'token': token!,
    });
    if (Response.statusCode == 200) {
      print('Item added to saved items successfully');
    } else {
      // Error handling
      var decodedResponse = jsonDecode(Response.body) as Map<String, dynamic>;
      print('Failed to add item: ${decodedResponse['msg']}');
    }
  }

//21- get category items api
  static Future<List<Item>> getItemsOFCategory(
      String token, String categoryID) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.categoryEndpoint.getItemsOFCategory +
        categoryID);
    final Response = await http.get(url, headers: {
      'token': token,
    });
    List _temp = [];
    if (Response.statusCode == 200) {
      Map data = jsonDecode(Response.body);
      if (data['data'] != null) {
        for (var i in data['data']) {
          _temp.add(i);
        }
      }
    }
    print(_temp);
    return Item.itemsFromSnapshot(_temp);
  }

//22- getitems for one user  by user idapi
  static Future<List<Item>> getitemsforuserbyid(String ID) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.userEndPoint.useritemsByid +
        ID);
    final Response = await http.get(url);
    var data = jsonDecode(Response.body);
    List _temp = [];

    for (var i in data['data']) {
      _temp.add(i);
    }
    print(_temp);
    return Item.itemsFromSnapshot(_temp);
  }

//23- get recent post items api
  static Future<List<Item>> recentPost(String token) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.itemEdPoint.recentPost);
    final Response = await http.get(url, headers: {'token': token});
    var data = jsonDecode(Response.body);
    List _temp = [];
    print('apiiii ${Response.body}');
    for (var i in data['data']) {
      _temp.add(i);
    }
    return Item.itemsFromSnapshot(_temp);
  }

//24- get pandding requests api
  static Future<List<Request>> getrequests(String? token) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.requestsEndPoint.getRequests);
    final Response = await http.get(url, headers: {'token': token!});
    List _temp = [];

    if (Response.statusCode == 200) {
      var data = jsonDecode(Response.body);
      print('apiiii requests ${Response.body}');
      for (var i in data) {
        _temp.add(i);
      }
    }
    return Request.RequestsFromSnapshot(_temp);
  }

//25- accept or reject request
  static Future<void> responseRequest(
      String RequestID, String? token, String response) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.requestsEndPoint.AcceptORreject +
        RequestID);
    final Response = await http.put(url,
        body: jsonEncode({'response': response.toString()}),
        headers: {'Content-Type': 'application/json', 'token': token!});
    if (Response.statusCode == 200) {
      print('request ${response} successfully');
      Get.off(RequestsTabContainerScreen());
    } else {
      print(' ${Response.body}');
    }
  }

//26- delete from saved items
  static Future<void> DeletefromSaved(String? token, String itemID) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.itemEdPoint.deletefromsaved +
        itemID);
    final Response = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'token': token!,
    });
    if (Response.statusCode == 200) {
      print('Item delete from saved items successfully');
    } else {
      // Error handling
      print('Failed to add item');
    }
  }

//27-recommendation
  static Future<List<Recommendation>> fetchRecommendations(
      String itemName) async {
    final String apiUrl = "http://192.168.1.9:4000/recommend/${itemName}";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Recommendation> recommendations =
          body.map((dynamic item) => Recommendation.fromJson(item)).toList();
      print("  recommmendationnnnnnnnn $recommendations");
      return recommendations;
    } else {
      throw Exception('Failed to load recommendations');
    }
  }

  //28- get expired items api
  static Future<List<Item>> getExpiredItems(String token) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.itemEdPoint.getExpireditem);
    final Response = await http.get(url, headers: {'token': token});
    var data = jsonDecode(Response.body);
    List _temp = [];
    for (var i in data['data']) {
      _temp.add(i);
    }
    return Item.itemsFromSnapshot(_temp);
  }

//29- get accepted requests api
  static Future<List<Request>> getAcceptedrequests(String? token) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.requestsEndPoint.getAcceptedRequests);
    final Response = await http.get(url, headers: {'token': token!});
    List _temp = [];

    if (Response.statusCode == 200) {
      var data = jsonDecode(Response.body);
      print('apiiii requests ${Response.body}');
      for (var i in data) {
        _temp.add(i);
      }
    }
    return Request.RequestsFromSnapshot(_temp);
  }

//30- get rejected requests api
  static Future<List<Request>> getRejectedrequests(String? token) async {
    var url = Uri.parse(ApiEndPoints.baseUrl.trim() +
        ApiEndPoints.requestsEndPoint.getRejectedRequests);
    final Response = await http.get(url, headers: {'token': token!});
    List _temp = [];

    if (Response.statusCode == 200) {
      var data = jsonDecode(Response.body);
      print('apiiii requests ${Response.body}');
      for (var i in data) {
        _temp.add(i);
      }
    }
    return Request.RequestsFromSnapshot(_temp);
  }

//31 send photo in chat
  static Future<void> sendPhotoMessage(
      String? token, String recipientId, String chatId, File imageFile) async {
    final url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.chatsEndPoint.Sendphoto);
    final request = http.MultipartRequest('POST', url)
      ..headers['token'] = token!
      ..fields['recipientId'] = recipientId
      ..fields['chatId'] = chatId
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      print(' send photo API $responseData');
    } else {
      print('Failed to send photo message ${response.statusCode}');
    }
  }

  //32- get Pending items api
  static Future<List<Item>> getPendingItems(String token) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.itemEdPoint.getPendingItems);
    final Response = await http.get(url, headers: {'token': token});
    var data = jsonDecode(Response.body);
    List _temp = [];
    for (var i in data['data']) {
      _temp.add(i);
    }
    return Item.itemsFromSnapshot(_temp);
  }
}
