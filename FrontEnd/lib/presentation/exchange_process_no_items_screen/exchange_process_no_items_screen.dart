import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ExchangeProcessNoItemsScreen extends StatelessWidget {
  ExchangeProcessNoItemsScreen({Key? key}) : super(key: key);

  TextEditingController inputController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 5.v),
                        child: Column(children: [
                          Container(
                              height: 1.v,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer
                                      .withOpacity(1))),
                          SizedBox(height: 68.v),
                          _buildNineteen(context),
                          SizedBox(height: 15.v),
                          _buildProductInfo(context),
                          SizedBox(height: 17.v),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 22.h),
                                  child: Text("Description",
                                      style: theme.textTheme.titleMedium))),
                          SizedBox(height: 2.v),
                          Padding(
                              padding: EdgeInsets.only(left: 22.h, right: 32.h),
                              child: CustomTextFormField(
                                  controller: inputController,
                                  hintText: "Description",
                                  textInputAction: TextInputAction.done,
                                  maxLines: 6,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.h, vertical: 16.v))),
                          SizedBox(height: 25.v),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 22.h),
                                  child: Text("Exchange with",
                                      style: theme.textTheme.titleMedium))),
                          SizedBox(height: 38.v),
                          CustomImageView(
                              imagePath: ImageConstant.imgVideoCamera,
                              height: 67.v,
                              width: 96.h),
                          SizedBox(height: 34.v),
                          Text("You have no items to Exchange",
                              style: theme.textTheme.titleMedium),
                          SizedBox(height: 30.v),
                          CustomElevatedButton(
                              text: "Add Item",
                              margin: EdgeInsets.symmetric(horizontal: 16.h),
                              buttonTextStyle: CustomTextStyles
                                  .titleSmallInterPrimaryContainer)
                        ])))),
            ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftTeal900,
            margin: EdgeInsets.only(left: 16.h, top: 14.v, bottom: 14.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title:
            AppbarTitle(text: "Item Name", margin: EdgeInsets.only(left: 16.h)),
        styleType: Style.bgOutline);
  }

  /// Section Widget
  Widget _buildNineteen(BuildContext context) {
    return SizedBox(
        height: 216.v,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.topRight, children: [
          CustomImageView(
              imagePath: ImageConstant.imgPhoto,
              height: 216.v,
              width: 360.h,
              alignment: Alignment.center),
          CustomImageView(
              imagePath: ImageConstant.imgFavIconGray5002,
              height: 20.adaptSize,
              width: 20.adaptSize,
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 16.v, right: 24.h))
        ]));
  }

  /// Section Widget
  Widget _buildProductInfo(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Redmi Power bank", style: theme.textTheme.bodyLarge),
                SizedBox(height: 3.v),
                Text("600 L.E", style: CustomTextStyles.titleMediumPrimary)
              ]),
              Padding(
                  padding: EdgeInsets.only(top: 4.v, bottom: 32.v),
                  child: Text("1/1/2024", style: CustomTextStyles.bodySmall9))
            ]));
  }


  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
