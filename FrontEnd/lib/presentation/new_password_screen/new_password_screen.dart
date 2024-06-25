import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController newpasswordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 15.h,
                  top: 134.v,
                  right: 15.h,
                ),
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLogo,
                      height: 36.v,
                      width: 124.h,
                    ),
                    SizedBox(height: 63.v),
                    Text(
                      "Create new Password",
                      style: CustomTextStyles.titleLarge22,
                    ),
                    SizedBox(height: 47.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "New Password",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 2.v),
                    CustomTextFormField(
                      controller: newpasswordController,
                      hintText: "Password",
                      textInputType: TextInputType.visiblePassword,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(10.h, 10.v, 5.h, 10.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgLocksvgrepocom,
                          height: 20.adaptSize,
                          width: 20.adaptSize,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 40.v,
                      ),
                      suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 10.v, 10.h, 10.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgEyePrimary,
                          height: 19.adaptSize,
                          width: 19.adaptSize,
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 40.v,
                      ),
                      obscureText: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 11.v),
                    ),
                    SizedBox(height: 23.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Confirm Password",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 2.v),
                    CustomTextFormField(
                      controller: confirmpasswordController,
                      hintText: "Password",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(10.h, 10.v, 5.h, 10.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgLocksvgrepocom,
                          height: 20.adaptSize,
                          width: 20.adaptSize,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 40.v,
                      ),
                      suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 10.v, 10.h, 10.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgEyePrimary,
                          height: 19.adaptSize,
                          width: 19.adaptSize,
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 40.v,
                      ),
                      obscureText: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 11.v),
                    ),
                    SizedBox(height: 80.v),
                    CustomElevatedButton(
                      text: "Create Password",
                      margin: EdgeInsets.only(
                        left: 10.h,
                        right: 11.h,
                      ),
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
