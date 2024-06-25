import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/presentation/masseges_screen/masseges_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:christine_s_application20/api/apimethods.dart';
import 'package:christine_s_application20/models/MessageModel.dart';
import 'package:christine_s_application20/models/userModel.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../main.dart';

class ChatScreen extends StatefulWidget {
  final String reciverid;
  final String reciverName;
  final String image;
  final String? chatID;

  ChatScreen(
      {Key? key,
      required this.reciverid,
      required this.reciverName,
      this.chatID,
      required this.image})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  late IO.Socket socket;
  File? selesctedItemIamge;

  Future pickimage() async {
    final returnedIamge =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedIamge == null) return;
    setState(() {
      selesctedItemIamge = File(returnedIamge!.path);
    });
  }

  bool is_loading = true;
  bool is_loading_user = true;
  List<Message> _Messages = [];

  User? _user;
  String? token = sharedPreferences.getString('token');

  @override
  void initState() {
    super.initState();
    initializeChat();

    // Connect to the WebSocket server
    socket = IO.io('http://192.168.1.9:8000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.on('chat message', (data) {
      // Handle received message data
      print('Received message: $data');
    });
  }

  void sendMessage() async {
    var messageJson = {
      'sender': _user!.id.toString(),
      'text': messageController.text,
      'date': DateTime.now().toIso8601String(),
    };
    socket.emit('chat message', messageJson);
    print(messageJson);
    await ApisMethods.sendMessage(
        widget.reciverid.toString(), messageController.text, token!);
    try {
      setState(() {
        _Messages.add(Message.fromjson(messageJson));
      });
    } catch (e) {
      print("Error parsing message data: $e");
      print("Received JSON: $messageJson");
    }
    messageController.clear();
  }

  Future<void> initializeChat() async {
    _user = await ApisMethods.getuserinfo(token);
    if (_user != null) {
      _Messages =
          await ApisMethods.getMessages(_user!.id.toString(), widget.reciverid);

      setState(() {
        is_loading_user = false;
        is_loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: is_loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _Messages.length,
                      itemBuilder: (context, index) {
                        return _user!.id.toString() == _Messages[index].sender
                            ? buildsender(
                                _Messages[index].text!,
                                DateFormat('HH:mm')
                                    .format(_Messages[index].date),
                              )
                            : buildmessage(
                                _Messages[index].text!,
                                DateFormat('HH:mm')
                                    .format(_Messages[index].date),
                              );
                      },
                    ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40,
      leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgArrowLeftTeal900,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessagesScreen()));
          }),
      title: Row(
        children: [
          CachedNetworkImage(
            imageUrl: '${widget.image.trim()}',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: 34.adaptSize,
            width: 34.adaptSize,
            alignment: Alignment.center,
          ),
          AppbarTitle(
              text: "${widget.reciverName}", margin: EdgeInsets.only(left: 16)),
        ],
      ),
      styleType: Style.bgOutline_1,
    );
  }

  Widget buildmessage(String text, String time) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 11.v),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${text}',
                style: theme.textTheme.bodyMedium,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 8.v),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text('${time}', style: theme.textTheme.bodySmall))
            ]));
  }

  Widget buildsender(String text, String time) {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.only(right: 16.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgCheckmark,
                  height: 11.adaptSize,
                  width: 11.adaptSize,
                  margin: EdgeInsets.only(top: 33.v, bottom: 27.v)),
              Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child:
                      _buildMessage3(context, text: "${text}", time: "${time}"))
            ])));
  }

  Widget _buildMessage3(
    BuildContext context, {
    required String text,
    required String time,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 11.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.customBorderTL161),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text,
                  maxLines: 100,
                  style: CustomTextStyles.bodyMediumPrimaryContainer.copyWith(
                      color:
                          theme.colorScheme.primaryContainer.withOpacity(1))),
              SizedBox(height: 8.v),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(time,
                      style: CustomTextStyles.bodySmallPrimaryContainer
                          .copyWith(
                              color: theme.colorScheme.primaryContainer
                                  .withOpacity(1))))
            ]));
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: messageController,
              hintText: "Type a Message",
              textInputAction: TextInputAction.done,
              suffixConstraints: BoxConstraints(maxHeight: 48.v),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              sendMessage();
            },
          ),
        ],
      ),
    );
  }
}
