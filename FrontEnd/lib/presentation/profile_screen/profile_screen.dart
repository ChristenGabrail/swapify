import 'package:christine_s_application20/presentation/edit_email_screen/edit_email_screen.dart';
import 'package:christine_s_application20/presentation/edit_location_screen/edit_location_screen.dart';
import 'package:christine_s_application20/presentation/edit_password_screen/edit_password_screen.dart';
import 'package:christine_s_application20/presentation/edit_phonenumber_screen/edit_phonenumber_screen.dart';
import 'package:christine_s_application20/presentation/edit_username_screen/edit_username_screen.dart';
import 'package:christine_s_application20/presentation/published_tab_container_screen/published_tab_container_screen.dart';
import 'package:christine_s_application20/presentation/requests_tab_container_screen/requests_tab_container_screen.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import 'dart:convert';
import '../../api/apiendpoints.dart';
import '../../main.dart';
import '../../models/userModel.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/buildLogo.dart';
import 'package:http/http.dart' as http;
import '../../widgets/app_bar/custom_app_bar.dart';
import '../requests_page/Rejectedrequests_page.dart';

// ignore_for_file: must_be_immutable
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  String? token = sharedPreferences.getString('token');
/*
  User? _user;

  Future<void> getuser() async {
    _user = await ApisMethods.getuserinfo(token);
    setState(() {
      _isLoading = false;
    });
  }
*/

  //getuserinfo api
  Future<User> fetchUser(String? token) async {
    var url = Uri.parse(
        ApiEndPoints.baseUrl.trim() + ApiEndPoints.userEndPoint.UserInfo);
    final Response = await http.get(url, headers: {'token': "$token"});
    var data = jsonDecode(Response.body);
    print('useeer ${data['data']}');
    return User.fromJson(data['data']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: FutureBuilder(
        future: fetchUser(token!),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 5.v),
                        child: Column(children: [
                          Container(
                              height: 1.v,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer
                                      .withOpacity(1))),
                          SizedBox(height: 4.v),
                          buildLogo(),
                          SizedBox(height: 26.v),
                          _buildBrLine(context),
                          SizedBox(height: 32.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: _buildLocation(
                                context,
                                mdiLocation: ImageConstant.imgUsersvgrepocom,
                                location: "Username",
                                helwanCairo: "${snapshot.data?.username}",
                                onTapArrowRight: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditUsernameScreen(
                                                  user: snapshot.data!)));
                                },
                              )),
                          SizedBox(height: 16.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.h),
                              child: _buildLocation(
                                context,
                                mdiLocation: ImageConstant.imgMdiemailoutline,
                                location: "Email",
                                helwanCairo: "${snapshot.data?.email}",
                                onTapArrowRight: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditEmailScreen(
                                              user: snapshot.data!)));
                                },
                              )),
                          SizedBox(height: 16.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: _buildLocation(
                                context,
                                mdiLocation: ImageConstant.imgMdilocation,
                                location: "Location",
                                helwanCairo:
                                    "${snapshot.data?.city} , ${snapshot.data?.governorate}",
                                onTapArrowRight: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditLocationScreen(
                                                  user: snapshot.data!)));
                                },
                              )),
                          SizedBox(height: 11.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: _buildLocation(
                                context,
                                mdiLocation: ImageConstant.imgGgphone,
                                location: "Phone number",
                                helwanCairo: "${snapshot.data?.phone}",
                                onTapArrowRight: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditPhonenumberScreen(
                                                  user: snapshot.data!)));
                                },
                              )),
                          SizedBox(height: 11.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: _buildLocation(
                                context,
                                mdiLocation: ImageConstant.imgLocksvgrepocom,
                                location: "Password",
                                helwanCairo: "*******",
                                onTapArrowRight: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditPasswordScreen()));
                                },
                              )),
                          SizedBox(height: 32.v),
                          SizedBox(width: 220.h, child: Divider()),
                          SizedBox(height: 31.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: _buildBodyCare(context,
                                  letsIconsBoxes:
                                      ImageConstant.imgLetsIconsBoxes,
                                  publishedItems: "Published Items",
                                  onTapArrowRight: () {
                                onTapPublished(context);
                              }))
                        ]))));
          }
        },
      ),
    ));
  }

  /// Section Widget
  Widget _buildBrLine(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 9.v, bottom: 7.v),
                  child: SizedBox(width: 108.h, child: Divider())),
              Padding(
                  padding: EdgeInsets.only(left: 15.h),
                  child: Text("Personal info",
                      style: CustomTextStyles.bodySmallTeal900)),
              Padding(
                  padding: EdgeInsets.only(top: 9.v, bottom: 7.v),
                  child: SizedBox(width: 123.h, child: Divider(indent: 15.h)))
            ]));
  }

  /// Common widget
  Widget _buildLocation(
    BuildContext context, {
    required String mdiLocation,
    required String location,
    required String helwanCairo,
    Function? onTapArrowRight,
  }) {
    return GestureDetector(
      onTap: () {
        onTapArrowRight!.call();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.v),
          decoration: AppDecoration.fillBlue
              .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                    imagePath: mdiLocation,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    margin: EdgeInsets.only(bottom: 1.v)),
                Padding(
                    padding: EdgeInsets.only(left: 8.h, bottom: 1.v),
                    child: Text(location,
                        style: CustomTextStyles.titleSmallOnPrimaryContainer
                            .copyWith(
                                color: theme.colorScheme.onPrimaryContainer))),
                Spacer(),
                Padding(
                    padding: EdgeInsets.only(top: 2.v, bottom: 1.v),
                    child: Text(helwanCairo,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: appTheme.blueGray400))),
                CustomImageView(
                    imagePath: ImageConstant.imgVector3,
                    height: 9.v,
                    width: 4.h,
                    margin: EdgeInsets.only(left: 30.h, top: 6.v, bottom: 6.v))
              ])),
    );
  }

  /// Common widget
  Widget _buildBodyCare(
    BuildContext context, {
    required String letsIconsBoxes,
    required String publishedItems,
    Function? onTapArrowRight,
  }) {
    return GestureDetector(
        onTap: () {
          onTapArrowRight!.call();
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.v),
            decoration: AppDecoration.fillBlue
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                      imagePath: letsIconsBoxes,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                      margin: EdgeInsets.only(bottom: 1.v)),
                  Padding(
                      padding: EdgeInsets.only(left: 8.h, bottom: 1.v),
                      child: Text(publishedItems,
                          style: CustomTextStyles.titleSmallOnPrimaryContainer
                              .copyWith(
                                  color:
                                      theme.colorScheme.onPrimaryContainer))),
                  Spacer(),
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowRight,
                    height: 13.v,
                    width: 6.h,
                    margin: EdgeInsets.symmetric(vertical: 4.v),
                  )
                ])));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftTeal900,
        onTap: () => Navigator.of(context).pop(),
      ),
      title: AppbarTitle(text: "Profile"),
      styleType: Style.bgOutline,
    );
  }

  /// Navigates to the publishedTabContainerScreen when the action is triggered.
  onTapPublished(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PublishedTabContainerScreen()));
  }
}
