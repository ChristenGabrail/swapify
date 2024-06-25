import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/models/userModel.dart';
import 'package:christine_s_application20/navbar/NavMenu.dart';
import 'package:christine_s_application20/presentation/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import 'package:christine_s_application20/models/Chatmodel.dart';
import 'package:christine_s_application20/api/apimethods.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  bool is_loading = true;
  List<Chat>? _chats;

  String? token = sharedPreferences.getString('token');

  @override
  void initState() {
    super.initState();
    getchats();
  }

  Future<void> getchats() async {
    _chats = await ApisMethods.getChats(token!);
    setState(() {
      is_loading = false;
    });
    if (_chats != null && _chats!.isNotEmpty) {
      for (var chat in _chats!) {
        chat.userInfo = await ApisMethods.getuserinfoForItem(chat.userId);
      }
      setState(() {
        is_loading = false;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text("Last Chats",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              SizedBox(height: 16),
              is_loading
                  ? Center(child: CircularProgressIndicator())
                  : _chats!.isNotEmpty || _chats! != []
                      ? Expanded(child: _buildMsg3(context))
                      : Center(child: Text('Start Chat')) // Wrapped in Expanded
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40,
      leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgArrowLeftTeal900,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NAVmenu()));
          }),
      title: AppbarTitle(text: " Messages"),
      styleType: Style.bgOutline,
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required String name,
    required String date,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(name,
          style: CustomTextStyles.titleSmallTeal900
              .copyWith(color: appTheme.teal900)),
      Padding(
          padding: EdgeInsets.only(top: 3.v),
          child: Text(date,
              style: CustomTextStyles.bodySmallTeal900
                  .copyWith(color: appTheme.teal900)))
    ]);
  }

  Widget _buildMsg3(BuildContext context) {
    return ListView.builder(
      itemCount: _chats!.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                        chatID: _chats![index].chatId,
                        image: _chats![index].userInfo!.image,
                        reciverid: _chats![index].userId,
                        reciverName: _chats![index].username)));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: '${_chats![index].userInfo?.image.trim()}',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 50,
                  width: 49,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context,
                          name: "${_chats![index].username}",
                          date:
                              "${DateFormat('HH:mm').format(_chats![index].date)}"),
                      SizedBox(height: 8),
                      _chats![index].photo == null
                          ? Text(
                              _chats![index].lastMessText!,
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          : Row(
                              children: [
                                Icon(Icons.image),
                                Text(
                                  'Photo',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
