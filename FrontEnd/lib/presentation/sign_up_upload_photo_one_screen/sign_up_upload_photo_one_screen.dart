import 'dart:io';

import 'package:christine_s_application20/api/apimethods.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title_image.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';

class SignUpUploadPhotoOneScreen extends StatefulWidget {
  const SignUpUploadPhotoOneScreen({Key? key}) : super(key: key);

  @override
  State<SignUpUploadPhotoOneScreen> createState() =>
      _SignUpUploadPhotoOneScreenState();
}

class _SignUpUploadPhotoOneScreenState
    extends State<SignUpUploadPhotoOneScreen> {
  String? token = sharedPreferences.getString('token');
  File? selectedImage;

  Future pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 6.v),
            child: Column(
              children: [
                _buildPageHeader(context),
                SizedBox(height: 10.v),
                _buildRegistrationSteps(context),
                SizedBox(height: 61.v),
                selectedImage == null
                    ? Container(
                        height: 221.adaptSize,
                        width: 221.adaptSize,
                        padding: EdgeInsets.only(top: 80.v),
                        decoration: AppDecoration.outlinePrimary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder110),
                        child: GestureDetector(
                          onTap: pickImage,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgThumbsUpPrimary,
                            height: 56.v,
                            width: 49.h,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      )
                    : Image.file(
                        selectedImage!,
                        height: 350.v,
                        width: 100.h,
                        alignment: Alignment.topCenter,
                      ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 25.h, right: 26.h, bottom: 30.v),
          child: selectedImage == null
              ? _buildCreateAccount(context)
              : _buildCreateAccount2(context),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 150.v,
      leadingWidth: 150.h,
      leading: Container(
        height: 36.adaptSize,
        width: 36.adaptSize,
        child: CustomImageView(
          imagePath: ImageConstant.imgLogo,
          height: 200.adaptSize,
          width: 100.adaptSize,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(16.h, 8.v, 16.h, 7.v),
      decoration: AppDecoration.outlineGray,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.h, top: 4.v),
            child: Text("Upload photo", style: theme.textTheme.titleLarge),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRegistrationSteps(BuildContext context) {
    return SizedBox(
      height: 47.v,
      width: 323.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 9.h, top: 11.v),
              child: Text("User info", style: theme.textTheme.titleSmall),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 96.h),
              child: Text("Upload photo", style: theme.textTheme.titleSmall),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 72.h,
              margin: EdgeInsets.only(right: 25.h),
              child: Text(
                "Registration Successful!",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelLarge,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgRegisterationBarsBlueGray400,
            height: 17.v,
            width: 323.h,
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCreateAccount(BuildContext context) {
    return CustomElevatedButton(
      text: "Create Account",
      buttonStyle: CustomButtonStyles.fillBlueGray,
    );
  }

  Widget _buildCreateAccount2(BuildContext context) {
    return CustomElevatedButton(
      text: "Create Account",
      onPressed: () {
        ApisMethods.uploaduserphoto(token!, selectedImage!);
      },
    );
  }

  /// Navigates back to the previous screen.
  void onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
