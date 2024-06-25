import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore: must_be_immutable
class UsedItemWidget extends StatelessWidget {
  const UsedItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 119.v,
          width: 123.h,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgPic3,
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
                    left: 67.h,
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
                        margin: EdgeInsets.only(right: 8.h),
                      ),
                      SizedBox(height: 65.v),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        color: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: appTheme.blueGray400,
                            width: 1.h,
                          ),
                          borderRadius: BorderRadiusStyle.roundedBorder5,
                        ),
                        child: Container(
                          height: 20.v,
                          width: 50.h,
                          decoration: AppDecoration.outlineBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder5,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Used",
                                  style: CustomTextStyles.bodySmallGray5002,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 9.h),
                                  decoration:
                                      AppDecoration.outlineBluegray400.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder5,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 1.v),
                                      Text(
                                        "Used",
                                        style:
                                            CustomTextStyles.bodySmallGray5002,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 7.v),
        Padding(
          padding: EdgeInsets.only(left: 3.h),
          child: Text(
            "golden dog",
            style: CustomTextStyles.bodySmallTeal900,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 3.h),
          child: Text(
            "15000 L.E",
            style: CustomTextStyles.labelLargePrimary,
          ),
        ),
      ],
    );
  }
}
