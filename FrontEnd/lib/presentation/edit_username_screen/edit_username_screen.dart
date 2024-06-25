import 'package:christine_s_application20/api/apimethods.dart';
import 'package:christine_s_application20/models/userModel.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/presentation/profile_screen/profile_screen.dart';
import 'package:christine_s_application20/widgets/custom_icon_button.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../widgets/app_bar/buildLogo.dart';

class EditUsernameScreen extends StatefulWidget {
  User? user;
  EditUsernameScreen({Key? key, required this.user})
      : super(
          key: key,
        );

  @override
  State<EditUsernameScreen> createState() => _EditUsernameScreenState();
}

class _EditUsernameScreenState extends State<EditUsernameScreen> {
  String? token = sharedPreferences.getString('token');

  TextEditingController userNameController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                height: 1.v,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(1),
                ),
              ),
              SizedBox(height: 4.v),
              buildLogo(),
              SizedBox(height: 27.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text(
                    "Current Username",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
              SizedBox(height: 7.v),
              _buildUserName(context),
              SizedBox(height: 16.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text(
                    "New Username",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
              SizedBox(height: 7.v),
              _buildUserName1(context),
              Spacer(),
              SizedBox(height: 46.v),
              _buildBtns(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUserName(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${widget.user?.username}",
          ),
        ));
  }

  /// Section Widget
  Widget _buildUserName1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: CustomTextFormField(
        controller: userNameController,
        hintText: "",
        textInputAction: TextInputAction.done,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(10.h, 10.v, 5.h, 10.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgUsersvgrepocom,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 40.v,
        ),
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30.h, 12.v, 10.h, 12.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgSolarPenOutline,
            height: 15.adaptSize,
            width: 15.adaptSize,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 40.v,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 9.v),
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveChanges(BuildContext context) {
    return CustomElevatedButton(
      height: 48.v,
      width: 161.h,
      text: "Save Changes",
      onPressed: () {
        if (userNameController.text.isNotEmpty) {
          ApisMethods.updateUserInfo(
              token!,
              userNameController.text.toString(),
              widget.user!.email.toString(),
              widget.user!.phone.toString(),
              widget.user!.city.toString(),
              widget.user!.governorate.toString());
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
      },
    );
  }

  /// Section Widget
  Widget _buildDiscard(BuildContext context) {
    return CustomOutlinedButton(
      height: 48.v,
      width: 161.h,
      text: "Discard",
      onPressed: () => Navigator.pop(context),
      margin: EdgeInsets.only(left: 8.h),
      buttonStyle: CustomButtonStyles.outlineRed,
    );
  }

  /// Section Widget
  Widget _buildBtns(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSaveChanges(context),
          _buildDiscard(context),
        ],
      ),
    );
  }
}
