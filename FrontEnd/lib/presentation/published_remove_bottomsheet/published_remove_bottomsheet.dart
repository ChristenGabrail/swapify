import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore_for_file: must_be_immutable
class PublishedRemoveBottomsheet extends StatelessWidget {
  const PublishedRemoveBottomsheet({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 19.v,
      ),
      decoration: AppDecoration.white.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 296.h,
            margin: EdgeInsets.symmetric(horizontal: 15.h),
            child: Text(
              "Are you sure you want to remove this item permanently?",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodyLargeBlack900,
            ),
          ),
          SizedBox(height: 23.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomElevatedButton(
                  text: "Remove",
                  margin: EdgeInsets.only(right: 2.h),
                  buttonStyle: CustomButtonStyles.fillRed,
                ),
              ),
              Expanded(
                child: CustomOutlinedButton(
                  height: 45.v,
                  text: "Never",
                  margin: EdgeInsets.only(left: 2.h),
                  buttonStyle: CustomButtonStyles.outlinePrimary,
                  buttonTextStyle: CustomTextStyles.titleMediumPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
