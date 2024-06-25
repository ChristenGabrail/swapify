import 'package:christine_s_application20/presentation/login_screen/login_screen.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../main.dart';

// ignore_for_file: must_be_immutable
class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336.h,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 118.v,
      ),
      decoration: AppDecoration.white.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          Text(
            "You are about to log out.",
            style: CustomTextStyles.titleMediumOnPrimaryContainer,
          ),
          SizedBox(height: 29.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () {
                    sharedPreferences.remove('token');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  height: 41.v,
                  text: "Log Out",
                  margin: EdgeInsets.only(right: 6.h),
                  buttonStyle: CustomButtonStyles.fillRed,
                ),
              ),
              Expanded(
                child: CustomOutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Never",
                  margin: EdgeInsets.only(left: 6.h),
                  buttonStyle: CustomButtonStyles.outlinePrimaryTL8,
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
