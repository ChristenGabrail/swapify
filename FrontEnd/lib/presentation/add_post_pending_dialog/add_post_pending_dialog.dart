import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AddPostPendingDialog extends StatelessWidget {
  const AddPostPendingDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 321.h,
      padding: EdgeInsets.symmetric(
        horizontal: 17.h,
        vertical: 43.v,
      ),
      decoration: AppDecoration.white.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 14.v),
          CustomImageView(
            imagePath: ImageConstant.imgVectorPrimary113x113,
            height: 113.adaptSize,
            width: 113.adaptSize,
          ),
          SizedBox(height: 41.v),
          SizedBox(
            width: 285.h,
            child: Text(
              "Your request to add this item is pending wait until admin approves your request",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.titleMedium18,
            ),
          ),
        ],
      ),
    );
  }
}
