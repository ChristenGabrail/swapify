import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore: must_be_immutable
class RecentlypostedItemWidget extends StatelessWidget {
  RecentlypostedItemWidget({
    Key? key,
    this.onTapCardRec,
  }) : super(
          key: key,
        );

  VoidCallback? onTapCardRec;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          onTapCardRec!.call();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 119.v,
              width: 123.h,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgPic,
                    height: 119.v,
                    width: 123.h,
                    radius: BorderRadius.circular(
                      15.h,
                    ),
                    alignment: Alignment.center,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 71.h,
                        right: 6.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgFavIcon,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 5.h),
                          ),
                          SizedBox(height: 65.v),
                          Container(
                            width: 46.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.h,
                              vertical: 1.v,
                            ),
                            decoration: AppDecoration.outlineBlueGray.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder5,
                            ),
                            child: Text(
                              "New",
                              style: CustomTextStyles.bodySmallGray5002,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.v),
            Padding(
              padding: EdgeInsets.only(left: 3.h),
              child: Text(
                "Bluetooth Headset",
                style: CustomTextStyles.bodySmallTeal900,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.h),
              child: Text(
                "500 L.E",
                style: CustomTextStyles.bodySmallTeal900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
