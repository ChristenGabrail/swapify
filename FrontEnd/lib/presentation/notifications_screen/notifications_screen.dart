import 'package:christine_s_application20/widgets/custom_icon_button.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  Container(
                    height: 1.v,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withOpacity(1),
                    ),
                  ),
                  SizedBox(height: 92.v),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.h),
                          child: Text(
                            "Today",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(height: 5.v),
                        _buildNoti1(
                          context,
                          newMessage: "New message !",
                          justNow: "Just now",
                        ),
                        _buildNoti2(
                          context,
                          yourRequestTo:
                              "Your request to post has been rejected",
                          justNow: "Just now",
                        ),
                        SizedBox(height: 16.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.h,
                            right: 27.h,
                          ),
                          child: _buildNoti3(
                            context,
                            adminhasbeenapprovedyourreques:
                                "Admin has been approved your request to post",
                            justNow: "Just now",
                          ),
                        ),
                        SizedBox(height: 40.v),
                        Padding(
                          padding: EdgeInsets.only(left: 20.h),
                          child: Text(
                            "Yesterday",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(height: 13.v),
                        _buildNoti1(
                          context,
                          newMessage: "New message !",
                          justNow: "Just now",
                        ),
                        _buildNoti2(
                          context,
                          yourRequestTo:
                              "Your request to post has been rejected",
                          justNow: "Just now",
                        ),
                        SizedBox(height: 16.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.h,
                            right: 27.h,
                          ),
                          child: _buildNoti3(
                            context,
                            adminhasbeenapprovedyourreques:
                                "Admin has been approved your request to post",
                            justNow: "Just now",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Notifications",
        margin: EdgeInsets.only(left: 16.h),
      ),
      styleType: Style.bgOutline,
    );
  }



  /// Common widget
  Widget _buildNoti1(
    BuildContext context, {
    required String newMessage,
    required String justNow,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 16.v, 16.h, 15.v),
      decoration: AppDecoration.outlineGray50,
      child: Row(
        children: [
          CustomIconButton(
            height: 48.adaptSize,
            width: 48.adaptSize,
            padding: EdgeInsets.all(12.h),
            decoration: IconButtonStyleHelper.fillBlue,
            child: CustomImageView(
              imagePath: ImageConstant.imgLetsIconsMessageAltFill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.h,
              top: 2.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newMessage,
                  style: CustomTextStyles.titleSmallTeal900.copyWith(
                    color: appTheme.teal900,
                  ),
                ),
                SizedBox(height: 6.v),
                Text(
                  justNow,
                  style: CustomTextStyles.bodySmallOnError.copyWith(
                    color: theme.colorScheme.onError,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildNoti2(
    BuildContext context, {
    required String yourRequestTo,
    required String justNow,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 16.v, 16.h, 15.v),
      decoration: AppDecoration.outlineGray50,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.v),
            child: CustomIconButton(
              height: 48.adaptSize,
              width: 48.adaptSize,
              padding: EdgeInsets.all(12.h),
              decoration: IconButtonStyleHelper.fillGray,
              child: CustomImageView(
                imagePath: ImageConstant.imgErrorSvgrepoCom,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 211.h,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Your ",
                            style: CustomTextStyles.titleSmallff083344,
                          ),
                          TextSpan(
                            text: "request to post has been rejected",
                            style: CustomTextStyles.titleSmallff083344,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 6.v),
                  Text(
                    justNow,
                    style: CustomTextStyles.bodySmallOnError.copyWith(
                      color: theme.colorScheme.onError,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildNoti3(
    BuildContext context, {
    required String adminhasbeenapprovedyourreques,
    required String justNow,
  }) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 9.v),
          child: CustomIconButton(
            height: 48.adaptSize,
            width: 48.adaptSize,
            padding: EdgeInsets.all(12.h),
            decoration: IconButtonStyleHelper.fillGrayTL24,
            child: CustomImageView(
              imagePath: ImageConstant.imgSuccessSvgrepoCom,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 224.h,
                  child: Text(
                    adminhasbeenapprovedyourreques,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.titleSmallTeal900.copyWith(
                      color: appTheme.teal900,
                    ),
                  ),
                ),
                SizedBox(height: 6.v),
                Text(
                  justNow,
                  style: CustomTextStyles.bodySmallOnError.copyWith(
                    color: theme.colorScheme.onError,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
