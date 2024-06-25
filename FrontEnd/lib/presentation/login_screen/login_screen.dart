import 'package:christine_s_application20/presentation/sign_up_user_info_screen/sign_up_user_info_screen.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_checkbox_button.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../api/apimethods.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool keepmeloggedin = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool Seen = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(horizontal: 11.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                      imagePath: ImageConstant.imgLogo,
                                      height: 36.v,
                                      width: 200.h,
                                      margin: EdgeInsets.only(left: 5.h)),
                                  SizedBox(height: 47.v),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text("Welcome",
                                          style:
                                              CustomTextStyles.titleLarge22)),
                                  SizedBox(height: 17.v),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          "please enter you login details below",
                                          style: CustomTextStyles
                                              .bodySmallGray600)),
                                  SizedBox(height: 46.v),
                                  Padding(
                                      padding: EdgeInsets.only(left: 5.h),
                                      child: Text("Email",
                                          style: theme.textTheme.bodyMedium)),
                                  SizedBox(height: 2.v),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      child: CustomTextFormField(
                                          controller: emailController,
                                          hintText: "Email",
                                          textInputType:
                                              TextInputType.emailAddress,
                                          prefix: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  16.h, 10.v, 8.h, 10.v),
                                              child: CustomImageView(
                                                  imagePath: ImageConstant
                                                      .imgMdiemailoutline,
                                                  height: 20.adaptSize,
                                                  width: 20.adaptSize)),
                                          prefixConstraints:
                                              BoxConstraints(maxHeight: 40.v),
                                          contentPadding: EdgeInsets.only(
                                              top: 11.v,
                                              right: 30.h,
                                              bottom: 11.v))),
                                  SizedBox(height: 7.v),
                                  Padding(
                                      padding: EdgeInsets.only(left: 5.h),
                                      child: Text("Password",
                                          style: theme.textTheme.bodyMedium)),
                                  SizedBox(height: 2.v),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      child: CustomTextFormField(
                                          controller: passwordController,
                                          hintText: "Password",
                                          textInputAction: TextInputAction.done,
                                          textInputType:
                                              TextInputType.visiblePassword,
                                          prefix: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  16.h, 10.v, 8.h, 10.v),
                                              child: CustomImageView(
                                                  imagePath: ImageConstant
                                                      .imgLocksvgrepocom,
                                                  height: 20.adaptSize,
                                                  width: 20.adaptSize)),
                                          prefixConstraints:
                                              BoxConstraints(maxHeight: 40.v),
                                          suffix: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  30.h, 10.v, 16.h, 10.v),
                                              child: Seen == true
                                                  ? CustomImageView(
                                                      imagePath: ImageConstant
                                                          .imgEyePrimary,
                                                      onTap: (() {
                                                        setState(() {
                                                          Seen = false;
                                                        });
                                                      }),
                                                      height: 19.adaptSize,
                                                      width: 19.adaptSize)
                                                  : CustomImageView(
                                                      imagePath:
                                                          ImageConstant.seen,
                                                      onTap: (() {
                                                        setState(() {
                                                          Seen = true;
                                                        });
                                                      }),
                                                      height: 19.adaptSize,
                                                      width: 19.adaptSize)),
                                          suffixConstraints:
                                              BoxConstraints(maxHeight: 40.v),
                                          obscureText: Seen,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 11.v))),
                                  /*SizedBox(height: 9.v),
                                  GestureDetector(
                                      onTap: () {
                                        onTapTxtForgetPassword(context);
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 12.h),
                                          child: Text("Forget password",
                                              style: theme.textTheme.bodyMedium!
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .underline)))),
                                  SizedBox(height: 23.v),
                                  _buildKeepmeloggedin(context),
                                  SizedBox(height: 40.v),
                                  _buildBrLine(context),
                                  SizedBox(height: 22.v),
                                  CustomImageView(
                                      imagePath: ImageConstant.imgSettings,
                                      height: 30.v,
                                      width: 98.h,
                                      alignment: Alignment.center),*/
                                  SizedBox(height: 40.v),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30.h),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "Do you not have an account ?",
                                                    style: CustomTextStyles
                                                        .bodySmallGray500),
                                                GestureDetector(
                                                    onTap: () {
                                                      onTapTxtSIGNUP(context);
                                                    },
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.h),
                                                        child: Text("SIGN UP",
                                                            style: theme
                                                                .textTheme
                                                                .labelLarge!
                                                                .copyWith(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline))))
                                              ])))
                                ]))))),
            bottomNavigationBar: _buildLogin(context)));
  }

  /// Section Widget
  Widget _buildLogin(BuildContext context) {
    return CustomElevatedButton(
        text: "Login",
        onPressed: () async {
          print(emailController.text.toString());
          print(passwordController.text.toString());

          await ApisMethods.login(emailController.text.toString(),
              passwordController.text.toString());
        },
        margin: EdgeInsets.only(left: 25.h, right: 26.h, bottom: 52.v));
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  onTapTxtForgetPassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
  }

  /// Navigates to the signUpUserInfoScreen when the action is triggered.
  onTapTxtSIGNUP(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpUserInfoScreen()),
    );
  }
}
