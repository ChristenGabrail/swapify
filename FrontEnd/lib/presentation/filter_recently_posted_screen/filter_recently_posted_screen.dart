import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import '../filter_recently_posted_screen/widgets/condition_item_widget.dart';
import '../filter_recently_posted_screen/widgets/thirtysix_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore_for_file: must_be_immutable
class FilterRecentlyPostedScreen extends StatelessWidget {
  FilterRecentlyPostedScreen({Key? key}) : super(key: key);

  TextEditingController priceController = TextEditingController();

  TextEditingController inputController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 1.v,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer
                                  .withOpacity(1))),
                      Spacer(flex: 37),
                      Padding(
                          padding: EdgeInsets.only(left: 38.h),
                          child: Text("Price Range",
                              style: theme.textTheme.titleMedium)),
                      SizedBox(height: 14.v),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: EdgeInsets.only(left: 38.h, right: 35.h),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextFormField(
                                        width: 135.h,
                                        controller: priceController,
                                        hintText: "From",
                                        hintStyle: CustomTextStyles
                                            .labelLargeBluegray400_1),
                                    Padding(
                                        padding: EdgeInsets.only(left: 16.h),
                                        child: CustomTextFormField(
                                            width: 135.h,
                                            controller: inputController,
                                            hintText: "To",
                                            hintStyle: CustomTextStyles
                                                .labelLargeBluegray400_1,
                                            textInputAction:
                                                TextInputAction.done))
                                  ]))),
                      SizedBox(height: 31.v),
                      Padding(
                          padding: EdgeInsets.only(left: 38.h),
                          child: Text("Condition",
                              style: theme.textTheme.titleMedium)),
                      SizedBox(height: 16.v),
                      _buildCondition(context),
                      SizedBox(height: 34.v),
                      Padding(
                          padding: EdgeInsets.only(left: 38.h),
                          child: Text("Category",
                              style: theme.textTheme.titleMedium)),
                      SizedBox(height: 13.v),
                      _buildThirtySix(context),
                      Spacer(flex: 62)
                    ])),
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
        title: AppbarTitle(text: "Filter", margin: EdgeInsets.only(left: 16.h)),
        styleType: Style.bgOutline);
  }

  /// Section Widget
  Widget _buildCondition(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 38.h),
        child: Wrap(
            runSpacing: 16.v,
            spacing: 16.h,
            children:
                List<Widget>.generate(2, (index) => ConditionItemWidget())));
  }

  /// Section Widget
  Widget _buildThirtySix(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.only(right: 19.h),
            child: Wrap(
                runSpacing: 24.v,
                spacing: 24.h,
                children: List<Widget>.generate(
                    8, (index) => ThirtysixItemWidget()))));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
