import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:christine_s_application20/widgets/custom_icon_button.dart';
import 'package:get/get.dart';
import '../../api/apimethods.dart';
import '../../main.dart';
import '../../widgets/app_bar/buildLogo.dart';
import '../profile_screen/profile_screen.dart';

class EditPasswordScreen extends StatefulWidget {
  EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool Seen = true;
  bool newSeen = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      height: 1.v,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.primaryContainer.withOpacity(1),
                      ),
                    ),
                    SizedBox(height: 4.v),
                    buildLogo(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.h),
                        child: Text(
                          "Current Password",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 7.v),
                    _buildPassword(),
                    SizedBox(height: 16.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.h),
                        child: Text(
                          "New Password",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 7.v),
                    _buildNewpassword(),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: CustomTextFormField(
        controller: passwordController,
        hintText: "Enter Your password",
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(16.h, 10.v, 8.h, 10.v),
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
            margin: EdgeInsets.fromLTRB(30.h, 12.v, 16.h, 12.v),
            child: Seen == true
                ? CustomImageView(
                    onTap: () {
                      setState(() {
                        Seen = false;
                      });
                    },
                    imagePath: ImageConstant.imgEye,
                    height: 14.v,
                    width: 17.h,
                  )
                : CustomImageView(
                    onTap: () {
                      setState(() {
                        Seen = true;
                      });
                    },
                    imagePath: ImageConstant.seen,
                    height: 14.v,
                    width: 17.h,
                  )),
        suffixConstraints: BoxConstraints(
          maxHeight: 40.v,
        ),
        obscureText: Seen,
        contentPadding: EdgeInsets.symmetric(vertical: 11.v),
      ),
    );
  }

  Widget _buildNewpassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: CustomTextFormField(
        controller: newpasswordController,
        hintText: "Enter New Password",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 10.v, 8.h, 10.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgLocksvgrepocom,
              height: 20.adaptSize,
              width: 20.adaptSize,
            )),
        prefixConstraints: BoxConstraints(
          maxHeight: 40.v,
        ),
        suffix: Container(
            margin: EdgeInsets.fromLTRB(30.h, 12.v, 16.h, 12.v),
            child: newSeen == true
                ? CustomImageView(
                    imagePath: ImageConstant.imgEye,
                    onTap: () {
                      setState(() {
                        newSeen = false;
                      });
                    },
                    height: 14.v,
                    width: 17.h,
                  )
                : CustomImageView(
                    imagePath: ImageConstant.seen,
                    onTap: () {
                      setState(() {
                        newSeen = true;
                      });
                    },
                    height: 14.v,
                    width: 17.h,
                  )),
        suffixConstraints: BoxConstraints(
          maxHeight: 40.v,
        ),
        obscureText: newSeen,
        contentPadding: EdgeInsets.symmetric(vertical: 9.v),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildSaveChanges()), // Wrap with Expanded
          SizedBox(width: 8.h), // Adjust spacing based on your design
          Expanded(child: _buildDiscard()),
          // Wrap with Expanded
          SizedBox(width: 5.h), // Adjust spacing based on your design
        ],
      ),
    );
  }

  Widget _buildSaveChanges() {
    return CustomElevatedButton(
      text: "Save Changes",
      onPressed: () {
        if (passwordController.text.isNotEmpty &&
            newpasswordController.text.isNotEmpty) {
          ApisMethods.changePassword(
            token!,
            passwordController.text.toString(),
            newpasswordController.text.toString(),
          );
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

  Widget _buildDiscard() {
    return CustomOutlinedButton(
      text: "Discard",
      onPressed: () => Navigator.pop(context),
      buttonStyle: CustomButtonStyles.outlineRed,
    );
  }
}
