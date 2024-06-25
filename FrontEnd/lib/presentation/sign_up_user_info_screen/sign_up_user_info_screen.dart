import 'package:christine_s_application20/presentation/login_screen/login_screen.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_checkbox_button.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../api/apimethods.dart';

// ignore_for_file: must_be_immutable
class SignUpUserInfoScreen extends StatefulWidget {
  SignUpUserInfoScreen({Key? key}) : super(key: key);

  @override
  State<SignUpUserInfoScreen> createState() => _SignUpUserInfoScreenState();
}

class _SignUpUserInfoScreenState extends State<SignUpUserInfoScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController inputController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController governoratevalueController = TextEditingController();

  bool thumbsup = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool Seen = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 43.v),
                    child: Column(children: [
                      SizedBox(height: 19.v),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 5.v),
                                  child: Column(children: [
                                    CustomImageView(
                                        imagePath: ImageConstant.imgLogo,
                                        height: 36.v,
                                        width: 124.h,
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: 18.h)),
                                    SizedBox(height: 16.v),
                                    _buildPageHeader(context),
                                    SizedBox(height: 24.v),
                                    _buildRegisterationSteps(context),
                                    SizedBox(height: 23.v),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 18.h),
                                            child: Text("Username",
                                                style: theme
                                                    .textTheme.bodyMedium))),
                                    SizedBox(height: 2.v),
                                    _buildUserName(context),
                                    SizedBox(height: 15.v),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 18.h),
                                            child: Text("Email",
                                                style: theme
                                                    .textTheme.bodyMedium))),
                                    SizedBox(height: 2.v),
                                    _buildEmail(context),
                                    SizedBox(height: 15.v),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 18.h),
                                            child: Text("Phone number",
                                                style: theme
                                                    .textTheme.bodyMedium))),
                                    SizedBox(height: 2.v),
                                    _buildPhoneNumber(context),
                                    SizedBox(height: 15.v),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 18.h),
                                            child: Text("Password",
                                                style: theme
                                                    .textTheme.bodyMedium))),
                                    SizedBox(height: 2.v),
                                    _buildPassword(context),
                                    SizedBox(height: 15.v),
                                    _buildNinety(context),
                                    SizedBox(height: 16.v),
                                    _buildThumbsup(context),
                                    SizedBox(height: 41.v),
                                    _buildBrLine(context),
                                    SizedBox(height: 26.v),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Do you have an account ?",
                                              style: CustomTextStyles
                                                  .bodySmallGray500),
                                          GestureDetector(
                                              onTap: () {
                                                onTapTxtSIGNIN(context);
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.h),
                                                  child: Text("SIGN IN",
                                                      style: theme
                                                          .textTheme.labelLarge!
                                                          .copyWith(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline))))
                                        ]),
                                  ]))))
                    ]))),
            bottomNavigationBar: _buildNext(context)));
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.fromLTRB(16.h, 10.v, 16.h, 9.v),
        decoration: AppDecoration.outlineGray,
        child: Row(children: [
          CustomImageView(
              imagePath: ImageConstant.imgArrowLeftTeal900,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.symmetric(vertical: 3.v),
              onTap: () {
                onTapImgArrowLeft(context);
              }),
          Padding(
              padding: EdgeInsets.only(left: 16.h),
              child: Text("Create Account", style: theme.textTheme.titleLarge))
        ]));
  }

  /// Section Widget
  Widget _buildRegisterationSteps(BuildContext context) {
    return SizedBox(
        height: 47.v,
        width: 323.h,
        child: Stack(alignment: Alignment.topLeft, children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 9.h, top: 11.v),
                  child: Text("User info", style: theme.textTheme.titleSmall))),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 96.h, top: 13.v),
                  child:
                      Text("Upload photo", style: theme.textTheme.labelLarge))),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  width: 72.h,
                  margin: EdgeInsets.only(right: 25.h),
                  child: Text("Registration Successful!",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge))),
          CustomImageView(
              imagePath: ImageConstant.imgRegisterationBars,
              height: 17.v,
              width: 323.h,
              alignment: Alignment.bottomCenter)
        ]));
  }

  /// Section Widget
  Widget _buildUserName(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 18.h, right: 14.h),
        child: CustomTextFormField(
            controller: userNameController,
            hintText: "Username",
            prefix: Container(
                margin: EdgeInsets.fromLTRB(16.h, 6.v, 8.h, 6.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgUsersvgrepocom,
                    height: 20.adaptSize,
                    width: 20.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 33.v),
            contentPadding:
                EdgeInsets.only(top: 7.v, right: 30.h, bottom: 7.v)));
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 18.h, right: 14.h),
        child: CustomTextFormField(
            controller: emailController,
            hintText: "Email",
            textInputType: TextInputType.emailAddress,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(16.h, 10.v, 8.h, 10.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgMdiemailoutline,
                    height: 20.adaptSize,
                    width: 20.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 40.v),
            contentPadding:
                EdgeInsets.only(top: 11.v, right: 30.h, bottom: 11.v)));
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 18.h, right: 14.h),
        child: CustomTextFormField(
            controller: phoneNumberController,
            hintText: "+20",
            prefix: Container(
                margin: EdgeInsets.fromLTRB(16.h, 10.v, 8.h, 10.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgGgphone,
                    height: 20.adaptSize,
                    width: 20.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 40.v),
            contentPadding:
                EdgeInsets.only(top: 11.v, right: 30.h, bottom: 11.v)));
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 18.h, right: 14.h),
        child: CustomTextFormField(
            controller: passwordController,
            hintText: "Password",
            textInputType: TextInputType.visiblePassword,
            prefix: Container(
                margin: EdgeInsets.fromLTRB(16.h, 10.v, 8.h, 10.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgLocksvgrepocom,
                    height: 20.adaptSize,
                    width: 20.adaptSize)),
            prefixConstraints: BoxConstraints(maxHeight: 40.v),
            suffix: Container(
                margin: EdgeInsets.fromLTRB(30.h, 10.v, 16.h, 10.v),
                child: Seen == true
                    ? CustomImageView(
                        imagePath: ImageConstant.imgEyePrimary,
                        onTap: () {
                          setState(() {
                            Seen = false;
                          });
                        },
                        height: 19.adaptSize,
                        width: 19.adaptSize)
                    : CustomImageView(
                        imagePath: ImageConstant.seen,
                        onTap: () {
                          setState(() {
                            Seen = true;
                          });
                        },
                        height: 19.adaptSize,
                        width: 19.adaptSize)),
            suffixConstraints: BoxConstraints(maxHeight: 40.v),
            obscureText: Seen,
            contentPadding: EdgeInsets.symmetric(vertical: 11.v)));
  }

  /// Section Widget
  Widget _buildGovernorate(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Governorate", style: theme.textTheme.bodyMedium),
      SizedBox(height: 2.v),
      CustomTextFormField(
          width: 155.h,
          controller: governoratevalueController,
          hintText: "governorate",
          prefix: Container(
              margin: EdgeInsets.fromLTRB(10.h, 6.v, 5.h, 6.v),
              child: CustomImageView(
                  imagePath: ImageConstant.imgMdilocation,
                  height: 20.adaptSize,
                  width: 20.adaptSize)),
          prefixConstraints: BoxConstraints(maxHeight: 33.v))
    ]);
  }

  /// Section Widget
  Widget _buildCity(BuildContext context) {
    return CustomTextFormField(
        width: 155.h,
        controller: cityController,
        hintText: "city",
        textInputAction: TextInputAction.done,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(10.h, 6.v, 5.h, 6.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgMdilocation,
                height: 20.adaptSize,
                width: 20.adaptSize)),
        prefixConstraints: BoxConstraints(maxHeight: 33.v));
  }

  /// Section Widget
  Widget _buildNinety(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildGovernorate(context),
          Padding(
              padding: EdgeInsets.only(left: 13.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("City", style: theme.textTheme.bodyMedium),
                    SizedBox(height: 1.v),
                    _buildCity(context)
                  ]))
        ]));
  }

  /// Section Widget
  Widget _buildThumbsup(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 18.h),
            child: CustomCheckboxButton(
                alignment: Alignment.centerLeft,
                text: "I agree with the terms and conditions",
                value: thumbsup,
                textStyle: CustomTextStyles.bodySmallTeal900,
                onChange: (value) {
                  thumbsup = value;
                })));
  }

  /// Section Widget
  Widget _buildBrLine(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 7.v, bottom: 9.v),
                  child: SizedBox(width: 109.h, child: Divider())),
              Text("Or Sign up with", style: CustomTextStyles.bodySmallTeal900),
              Padding(
                  padding: EdgeInsets.only(top: 7.v, bottom: 9.v),
                  child: SizedBox(width: 109.h, child: Divider()))
            ]));
  }

  /// Section Widget
  Widget _buildNext(BuildContext context) {
    return CustomElevatedButton(
        onPressed: (() {
          ApisMethods.register(
              emailController.text,
              passwordController.text,
              userNameController.text,
              phoneNumberController.text,
              cityController.text,
              governoratevalueController.text);
        }),
        text: "Next",
        margin: EdgeInsets.only(left: 25.h, right: 26.h, bottom: 43.v));
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtSIGNIN(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
