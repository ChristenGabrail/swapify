import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class SuccessResetScreen extends StatelessWidget {
  const SuccessResetScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLogo,
                height: 36.v,
                width: 124.h,
              ),
              SizedBox(height: 56.v),
              CustomImageView(
                imagePath: ImageConstant.imgOffer,
                height: 82.v,
                width: 91.h,
              ),
              SizedBox(height: 49.v),
              SizedBox(
                width: 308.h,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Thank you.\n",
                        style: CustomTextStyles.titleLargeff083344,
                      ),
                      TextSpan(
                        text:
                            "Your password has been changed\n\nYou will be redirected to the login page in 5 seconds...\n",
                        style: CustomTextStyles.bodyLargeff083344,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 64.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 249.h,
                  margin: EdgeInsets.only(
                    left: 26.h,
                    right: 36.h,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Click ",
                          style: CustomTextStyles.titleLargeff083344,
                        ),
                        TextSpan(
                          text: "here if you are not redirected automatically",
                          style:
                              CustomTextStyles.titleLargeff083344Bold.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}
