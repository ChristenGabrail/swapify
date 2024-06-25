import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../../api/apimethods.dart';
import '../../core/utils/image_constant.dart';
import '../../main.dart';
import '../../models/userModel.dart';
import '../../theme/custom_text_style.dart';
import '../custom_icon_button.dart';
import '../custom_image_view.dart';
import 'appbar_trailing_image.dart';
import 'custom_app_bar.dart';

class buildLogo extends StatefulWidget {
  @override
  State<buildLogo> createState() => _buildLogoState();
}

class _buildLogoState extends State<buildLogo> {
  String? token = sharedPreferences.getString('token');

  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getuser();
  }

  Future<void> getuser() async {
    _user = await ApisMethods.getuserinfo(token);
    setState(() {
      _isLoading = false;
    });
  }

  /// Section Widget
  Widget build(BuildContext context) {
    return SizedBox(
      height: 203.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          CustomAppBar(
            height: 156.v,
            actions: [
              CustomImageView(
                imagePath: ImageConstant.imgLogoBlue50,
                height: 40.v,
                width: 140.h,
                margin: EdgeInsets.fromLTRB(38.h, 20.v, 50.h, 90.v),
              ),
            ],
            styleType: Style.bgFill,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.h),
              child: Row(
                children: [
                  SizedBox(
                    height: 97.v,
                    width: 92.h,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CachedNetworkImage(
                          imageUrl: '${_user?.image.trim()}',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 200.adaptSize,
                          width: 300.adaptSize,
                          alignment: Alignment.topCenter,
                        ),

                        //edit image
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.h,
                      top: 130.v,
                      bottom: 25.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_user?.username}",
                          style: CustomTextStyles.titleMediumBlue50,
                        ),
                        SizedBox(height: 3.v),
                        Text(
                          "${_user?.email}",
                          style: CustomTextStyles.bodyMediumBluegray400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
