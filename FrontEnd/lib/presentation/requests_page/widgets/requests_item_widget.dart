import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/api/apimethods.dart';
import 'package:christine_s_application20/main.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore: must_be_immutable
class RequestsItemWidget extends StatelessWidget {
  RequestsItemWidget(
      {Key? key,
      required this.RequesterName,
      this.onTapViewItem,
      required this.firstItem,
      required this.image,
      required this.secondItem,
      required this.RequestID})
      : super(
          key: key,
        );

  VoidCallback? onTapViewItem;
  String RequesterName;
  String image;
  String firstItem;
  String secondItem;
  String RequestID;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 7.v,
        bottom: 6.v,
      ),
      decoration: AppDecoration.outlineGray50,
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: '${image.trim()}',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: 48.adaptSize,
            width: 48.adaptSize,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                bottom: 1.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    RequesterName,
                    style: CustomTextStyles.titleSmallTeal900,
                  ),
                  SizedBox(height: 9.v),
                  SizedBox(
                    width: 190.h,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Sent you a request on your post\n",
                            style: CustomTextStyles.bodySmallff888888,
                          ),
                          TextSpan(
                            text: "“${firstItem}”\n",
                            style: CustomTextStyles.labelLargeff888888,
                          ),
                          TextSpan(
                            text: "with",
                            style: CustomTextStyles.bodySmallff888888,
                          ),
                          TextSpan(
                            text: " “${secondItem}”",
                            style: CustomTextStyles.labelLargeff888888,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(height: 7.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAccept(context),
                      _buildReject(context),
                      _buildViewItem(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAccept(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        onPressed: () async {
          await ApisMethods.responseRequest(RequestID, token!, 'accepted');
        },
        height: 25.v,
        text: "Accept",
        margin: EdgeInsets.only(right: 4.h),
        leftIcon: Container(
          margin: EdgeInsets.only(right: 3.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgIconparksolidcorrect,
            height: 15.adaptSize,
            width: 15.adaptSize,
          ),
        ),
        buttonStyle: CustomButtonStyles.fillGreenA,
        buttonTextStyle: CustomTextStyles.labelLargePrimaryContainer,
      ),
    );
  }

  /// Section Widget
  Widget _buildReject(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        onPressed: () async {
          await ApisMethods.responseRequest(RequestID, token!, 'rejected');
        },
        height: 25.v,
        text: "Reject",
        margin: EdgeInsets.symmetric(horizontal: 4.h),
        leftIcon: Container(
          margin: EdgeInsets.only(right: 3.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgVaadinclose,
            height: 12.adaptSize,
            width: 12.adaptSize,
          ),
        ),
        buttonTextStyle: CustomTextStyles.labelLargePrimary_1,
      ),
    );
  }

  /// Section Widget
  Widget _buildViewItem(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 25.v,
        text: "View Item",
        margin: EdgeInsets.only(left: 4.h),
        buttonStyle: CustomButtonStyles.fillPrimaryTL5,
        buttonTextStyle: CustomTextStyles.labelLargePrimaryContainer,
        onPressed: () {
          onTapViewItem!.call();
        },
      ),
    );
  }
}
