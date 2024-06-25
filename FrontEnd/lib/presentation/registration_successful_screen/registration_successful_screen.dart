import 'package:christine_s_application20/navbar/NavMenu.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import 'package:get/get.dart';

class RegistrationSuccessfulScreen extends StatelessWidget {
  const RegistrationSuccessfulScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NAVmenu()),
      );
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 39.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Registration Successful!",
                style: CustomTextStyles.titleLargeSecondaryContainer22,
              ),
              SizedBox(height: 20.v),
              CustomImageView(
                imagePath: ImageConstant.imgCircleCheck,
                height: 125.v,
                width: 122.h,
              ),
              SizedBox(height: 72.v),
              SizedBox(
                width: 277.h,
                child: Text(
                  "You will be redirected to the \nHome page in 5 seconds...",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleLargeSecondaryContainer,
                ),
              ),
              SizedBox(height: 50.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 249.h,
                  margin: EdgeInsets.only(
                    left: 10.h,
                    right: 20.h,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Click ",
                          style: CustomTextStyles.titleLargeff083344,
                        ),
                        TextSpan(
                          text: "here ",
                          onEnter: (event) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NAVmenu()),
                            );
                          },
                          style:
                              CustomTextStyles.titleLargeff083344Bold.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: "if you are not redirected automatically ",
                          style: CustomTextStyles.titleLargeff083344,
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
