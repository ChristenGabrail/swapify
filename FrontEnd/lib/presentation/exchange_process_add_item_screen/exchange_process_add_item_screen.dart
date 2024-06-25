import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/custom_icon_button.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_drop_down.dart';
import '../exchange_process_add_item_screen/widgets/conditioninput2_item_widget.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ExchangeProcessAddItemScreen extends StatelessWidget {
  ExchangeProcessAddItemScreen({Key? key}) : super(key: key);

  TextEditingController inputController = TextEditingController();

  TextEditingController inputController1 = TextEditingController();

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  TextEditingController priceController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(
                      height: 752.v,
                      width: double.maxFinite,
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
                        _buildSeventeen(context),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 21.h, right: 21.h, bottom: 17.v),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildHeader1(context),
                                      SizedBox(height: 3.v),
                                      Text("600 L.E",
                                          style: CustomTextStyles
                                              .titleMediumPrimary),
                                      SizedBox(height: 17.v),
                                      Text("Description",
                                          style: theme.textTheme.titleMedium),
                                      SizedBox(height: 2.v),
                                      _buildInput(context),
                                      SizedBox(height: 25.v),
                                      Text("Exchange with",
                                          style: theme.textTheme.titleMedium),
                                      SizedBox(height: 38.v),
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgVideoCamera,
                                          height: 67.v,
                                          width: 96.h,
                                          alignment: Alignment.center),
                                      SizedBox(height: 34.v),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "You have no items to Exchange",
                                              style:
                                                  theme.textTheme.titleMedium))
                                    ]))),
                        _buildPageHeader(context),
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                decoration: AppDecoration.fillBlueGray,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                          height: 1.v,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              color: theme
                                                  .colorScheme.primaryContainer
                                                  .withOpacity(1))),
                                      SizedBox(height: 39.v),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 7.h),
                                          padding: EdgeInsets.all(16.h),
                                          decoration: AppDecoration.white
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder15),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(height: 110.v),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.h),
                                                    child: CustomIconButton(
                                                        height: 42.adaptSize,
                                                        width: 42.adaptSize,
                                                        padding: EdgeInsets.all(
                                                            10.h),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: CustomImageView(
                                                            imagePath: ImageConstant
                                                                .imgSolarPenOutlineOnprimarycontainer))),
                                                SizedBox(height: 4.v),
                                                _buildHeader(context,
                                                    description: "Title"),
                                                SizedBox(height: 4.v),
                                                _buildInput1(context),
                                                SizedBox(height: 17.v),
                                                _buildHeader(context,
                                                    description: "Description"),
                                                SizedBox(height: 2.v),
                                                _buildInput2(context),
                                                SizedBox(height: 18.v),
                                                _buildHeader(context,
                                                    description: "Category"),
                                                SizedBox(height: 1.v),
                                                CustomDropDown(
                                                    hintText: "electronics",
                                                    items: dropdownItemList),
                                                SizedBox(height: 16.v),
                                                _buildHeader(context,
                                                    description: "Price (L.E)"),
                                                SizedBox(height: 3.v),
                                                _buildPrice(context),
                                                SizedBox(height: 15.v),
                                                Text("Condition",
                                                    style: theme
                                                        .textTheme.bodyMedium),
                                                SizedBox(height: 2.v),
                                                _buildConditionInput(context),
                                                SizedBox(height: 16.v),
                                                _buildBtns(context)
                                              ])),
                                      SizedBox(height: 88.v)
                                    ])))
                      ])),
                  SizedBox(height: 13.v),
                  _buildChatBtn(context)
                ]))),
            ));
  }

  /// Section Widget
  Widget _buildSeventeen(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            height: 216.v,
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 68.v),
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
            ])));
  }

  /// Section Widget
  Widget _buildHeader1(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Redmi Power bank", style: theme.textTheme.bodyLarge),
          Padding(
              padding: EdgeInsets.only(top: 4.v, bottom: 5.v),
              child: Text("1/1/2024", style: CustomTextStyles.bodySmall9))
        ]);
  }

  /// Section Widget
  Widget _buildInput(BuildContext context) {
    return Container(
        width: 306.h,
        margin: EdgeInsets.only(right: 11.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 15.v),
        decoration: AppDecoration.outlineBluegray400
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 76.v),
              Text("Description", style: theme.textTheme.bodySmall)
            ]));
  }

  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 16.v, bottom: 684.v),
            padding: EdgeInsets.fromLTRB(16.h, 10.v, 16.h, 9.v),
            decoration: AppDecoration.outlineGray5002,
            child: Row(children: [
              CustomImageView(
                  imagePath: ImageConstant.imgArrowLeftTeal900,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  margin: EdgeInsets.symmetric(vertical: 3.v),
                  onTap: () {
                    onTapImgArrowLeft(context);
                  }),
              Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text("Item Name", style: theme.textTheme.titleLarge))
            ])));
  }

  /// Section Widget
  Widget _buildInput1(BuildContext context) {
    return CustomTextFormField(
        controller: inputController, hintText: "Bluetooth headset");
  }

  /// Section Widget
  Widget _buildInput2(BuildContext context) {
    return CustomTextFormField(
        controller: inputController1, hintText: "description");
  }

  /// Section Widget
  Widget _buildPrice(BuildContext context) {
    return CustomTextFormField(
        controller: priceController,
        hintText: "500",
        textInputAction: TextInputAction.done);
  }

  /// Section Widget
  Widget _buildConditionInput(BuildContext context) {
    return Wrap(
        runSpacing: 6.v,
        spacing: 6.h,
        children:
            List<Widget>.generate(2, (index) => Conditioninput2ItemWidget()));
  }

  /// Section Widget
  Widget _buildAddItem(BuildContext context) {
    return Expanded(
        child: CustomElevatedButton(
            height: 41.v,
            text: "Add Item",
            margin: EdgeInsets.only(right: 4.h),
            buttonStyle: CustomButtonStyles.fillPrimaryTL5));
  }

  /// Section Widget
  Widget _buildDiscard(BuildContext context) {
    return Expanded(
        child: CustomOutlinedButton(
            text: "Discard",
            margin: EdgeInsets.only(left: 4.h),
            buttonStyle: CustomButtonStyles.outlineRedTL5));
  }

  /// Section Widget
  Widget _buildBtns(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildAddItem(context), _buildDiscard(context)]);
  }

  /// Section Widget
  Widget _buildChatBtn(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.h),
        padding: EdgeInsets.symmetric(vertical: 14.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Text("Add Item",
            textAlign: TextAlign.center,
            style: CustomTextStyles.titleSmallInterPrimaryContainer));
  }


  /// Common widget
  Widget _buildHeader(
    BuildContext context, {
    required String description,
  }) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description,
              style: CustomTextStyles.titleMediumMedium
                  .copyWith(color: appTheme.teal900)),
          CustomImageView(
              imagePath: ImageConstant.imgSolarPenOutline,
              height: 15.adaptSize,
              width: 15.adaptSize,
              margin: EdgeInsets.only(top: 2.v, bottom: 6.v))
        ]);
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
