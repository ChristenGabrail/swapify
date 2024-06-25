import 'package:christine_s_application20/models/userModel.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/buildLogo.dart';
import 'package:christine_s_application20/widgets/custom_icon_button.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import 'package:get/get.dart';

import '../../api/apimethods.dart';
import '../../main.dart';
import '../profile_screen/profile_screen.dart';

class EditLocationScreen extends StatefulWidget {
  User? user;
  EditLocationScreen({
    Key? key,
    required this.user,
  }) : super(
          key: key,
        );

  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  TextEditingController governorateController = TextEditingController();

  TextEditingController cityController = TextEditingController();
  String? token = sharedPreferences.getString('token');

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
              SizedBox(height: 26.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 27.h),
                  child: Text(
                    "Current Location",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
              SizedBox(height: 8.v),
              _buildLocation1(context),
              SizedBox(height: 15.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 27.h),
                  child: Text(
                    "New Location",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
              SizedBox(height: 8.v),
              _buildInput(context),
              SizedBox(height: 50.v),
              _buildBtns(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLocation(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "${widget.user?.governorate}",
      ),
    );
  }

  /// Section Widget
  Widget _buildCity1(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 4.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${widget.user?.city}",
          ),
        ));
  }

  /// Section Widget
  Widget _buildLocation1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLocation(context),
          _buildCity1(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCity(
            context,
            text: "-",
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: _buildCity(
              context,
              text: "-",
            ),
          ),
        ],
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
        if (cityController.text.isNotEmpty &&
            governorateController.text.isNotEmpty) {
          ApisMethods.updateUserInfo(
              token!,
              widget.user!.username.toString(),
              widget.user!.email.toString(),
              widget.user!.phone.toString(),
              cityController.text.toString(),
              governorateController.text.toString());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        } else if (cityController.text.isNotEmpty) {
          ApisMethods.updateUserInfo(
              token!,
              widget.user!.username.toString(),
              widget.user!.email.toString(),
              widget.user!.phone.toString(),
              cityController.text.toString(),
              widget.user!.governorate.toString());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        } else if (governorateController.text.isNotEmpty) {
          ApisMethods.updateUserInfo(
              token!,
              widget.user!.username.toString(),
              widget.user!.email.toString(),
              widget.user!.phone.toString(),
              widget.user!.city.toString(),
              governorateController.text.toString());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        } else {
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: Text('Error'),
                  contentPadding: EdgeInsets.all(20),
                  children: [Text('Black field not allowed')],
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

//mohmmm 3yza f haga tanya
  /// Common widget
  Widget _buildCity(
    BuildContext context, {
    required String text,
  }) {
    return Container(
      width: 151.h,
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 8.v,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgMdilocation,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.only(bottom: 1.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5.h,
              bottom: 1.v,
            ),
            child: Text(
              text,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: appTheme.teal900,
              ),
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgSolarPenOutline,
            height: 15.adaptSize,
            width: 15.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 3.v),
          ),
        ],
      ),
    );
  }
}
