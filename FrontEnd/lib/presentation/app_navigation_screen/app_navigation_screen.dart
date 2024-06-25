import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Login",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.loginScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign Up - user info",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.signUpUserInfoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign Up - upload photo One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.signUpUploadPhotoOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign Up - upload photo",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.signUpUploadPhotoScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Registration Successful",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.registrationSuccessfulScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Forgot Password",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.forgotPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Enter OTP",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.enterOtpScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "New Password",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.newPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Success Reset",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.successResetScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Home - Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.homeContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Notifications",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.notificationsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Favourites",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.favouritesScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Recently posted",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.recentlyPostedScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Filter - Recently posted",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.filterRecentlyPostedScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Categories",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.categoriesScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Electronics - cat - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.electronicsCatTabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Filter - cat",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.filterCatScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Edit username",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.editUsernameScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Edit Email",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.editEmailScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Edit Location",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.editLocationScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Edit phoneNumber",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.editPhonenumberScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Edit Password",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.editPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Profile",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.profileScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Requests - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.requestsTabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "View request",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.viewRequestScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "published - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.publishedTabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "published - update",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.publishedUpdateScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "item Hided - Update",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.itemHidedUpdateScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Item",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.itemScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "See profile",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.seeProfileScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Exchange process",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.exchangeProcessScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Exchange process - add item",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.exchangeProcessAddItemScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Exchange process - no items",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.exchangeProcessNoItemsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "no items - add item",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.noItemsAddItemScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Masseges",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.massegesScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Chat",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.chatScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Add post",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.addPostScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
