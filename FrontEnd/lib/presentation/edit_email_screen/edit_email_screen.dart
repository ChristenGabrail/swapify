import 'package:christine_s_application20/models/userModel.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/presentation/profile_screen/profile_screen.dart';
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

class EditEmailScreen extends StatefulWidget {
  final User? user;
  EditEmailScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditEmailScreen> createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  TextEditingController emailController = TextEditingController();
  String? token = sharedPreferences.getString('token');
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
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
                      padding: EdgeInsets.only(left: 16.h),
                      child: Text(
                        "Current Email",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.v),
                  _buildEmail(context),
                  SizedBox(height: 15.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Text(
                        "New Email",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.v),
                  _buildEmail1(context),
                  SizedBox(
                      height: 46
                          .v), // Replace Spacer with SizedBox for definitive spacing
                  _buildBtns(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "${widget.user?.email}",
          ),
        ));
  }

  Widget _buildEmail1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: CustomTextFormField(
        controller: emailController,
        hintText: "-",
        textInputAction: TextInputAction.done,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(16.h, 10.v, 8.h, 10.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgMdiemailoutline,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 40.v,
        ),
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30.h, 12.v, 16.h, 12.v),
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

  Widget _buildSaveChanges(BuildContext context) {
    return CustomElevatedButton(
      height: 48.v,
      width: 161.h,
      text: "Save Changes",
      onPressed: () {
        if (emailController.text.isNotEmpty) {
          ApisMethods.updateUserInfo(
              token!,
              widget.user!.username.toString(),
              emailController.text.toString(),
              widget.user!.phone.toString(),
              widget.user!.city.toString(),
              widget.user!.governorate.toString());
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
