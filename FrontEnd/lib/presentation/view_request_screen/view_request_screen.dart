import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/models/itemModel.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import '../../api/apimethods.dart';
import '../../main.dart';
import '../view_request_screen/widgets/conditioninput_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ViewRequestScreen extends StatefulWidget {
  Item item;
  String RequestID;
  ViewRequestScreen({Key? key, required this.RequestID, required this.item})
      : super(key: key);

  @override
  State<ViewRequestScreen> createState() => _ViewRequestScreenState();
}

class _ViewRequestScreenState extends State<ViewRequestScreen> {
  TextEditingController accessoriesController = TextEditingController();

  TextEditingController inputController = TextEditingController();

  TextEditingController inputController1 = TextEditingController();

  TextEditingController inputController2 = TextEditingController();

  TextEditingController priceController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
          height: 672.v,
          width: double.maxFinite,
          child: Stack(alignment: Alignment.center, children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: AppDecoration.fillBlueGray,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                          height: 1.v,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer
                                  .withOpacity(1))),
                      SizedBox(height: 30.v),
                      Container(
                          padding: EdgeInsets.all(16.h),
                          decoration: AppDecoration.white.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder15),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            _buildPageHeader1(context),
                            SizedBox(height: 16.v),
                            CachedNetworkImage(
                              imageUrl: '${widget.item.image.trim()}',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              height: 141.v,
                              width: 328.h,
                            ),
                            SizedBox(height: 15.v),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Title",
                                    style: CustomTextStyles.titleMediumMedium)),
                            SizedBox(height: 4.v),
                            _buildInput(context),
                            SizedBox(height: 17.v),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Description",
                                    style: CustomTextStyles.titleMediumMedium)),
                            SizedBox(height: 2.v),
                            _buildInput1(context),
                            SizedBox(height: 18.v),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Condition",
                                    style: CustomTextStyles.titleMediumMedium)),
                            SizedBox(height: 1.v),
                            _buildInput2(context),
                            SizedBox(height: 16.v),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Price (L.E)",
                                    style: CustomTextStyles.titleMediumMedium)),
                            SizedBox(height: 3.v),
                            _buildPrice(context),
                            SizedBox(height: 20.v),
                            _buildBtns(context)
                          ])),
                      SizedBox(height: 42.v)
                    ])))
          ])),
    ));
  }

/*
  /// Section Widget
  Widget _buildPageHeader(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 16.v, bottom: 604.v),
            padding: EdgeInsets.fromLTRB(18.h, 8.v, 18.h, 7.v),
            decoration: AppDecoration.outlineGray5002,
            child: Row(children: [
              CustomImageView(
                  imagePath: ImageConstant.imgArrowLeftTeal900,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  margin: EdgeInsets.symmetric(vertical: 5.v),
                  onTap: () {
                    onTapImgArrowLeft(context);
                  }),
              Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 5.v),
                  child: Text("Requests", style: theme.textTheme.titleLarge))
            ])));
  }
*/
  /// Section Widget
  Widget _buildAccessories(BuildContext context) {
    return CustomTextFormField(
        width: 80.h,
        controller: accessoriesController,
        hintText: "Pending",
        hintStyle: CustomTextStyles.bodySmallPrimary,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.h),
        borderDecoration: TextFormFieldStyleHelper.underLinePrimary,
        filled: false);
  }

  /// Section Widget
  Widget _buildHeader(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _buildAccessories(context),
          Padding(
              padding: EdgeInsets.only(top: 4.v, bottom: 3.v),
              child: Text("Accepted",
                  style: CustomTextStyles.bodySmallBlack900_1)),
          Padding(
              padding: EdgeInsets.only(top: 3.v, bottom: 4.v),
              child:
                  Text("Rejected", style: CustomTextStyles.bodySmallBlack900_1))
        ]));
  }

  /// Section Widget
  Widget _buildPageHeader1(BuildContext context) {
    return Container(
        width: 328.h,
        padding: EdgeInsets.fromLTRB(16.h, 8.v, 16.h, 7.v),
        decoration: AppDecoration.outlineGray,
        child: CustomImageView(
            imagePath: ImageConstant.imgArrowLeftTeal900,
            height: 24.adaptSize,
            width: 24.adaptSize,
            onTap: () {
              onTapImgArrowLeft1(context);
            }));
  }

  /// Section Widget
  Widget _buildInput(BuildContext context) {
    return Text(
      '${widget.item.Title}',
      style: CustomTextStyles.labelLargeBluegray400,
    );
  }

  /// Section Widget
  Widget _buildInput1(BuildContext context) {
    return Text(
      'description',
      style: CustomTextStyles.labelLargeBluegray400,
    );
  }

  /// Section Widget
  Widget _buildInput2(BuildContext context) {
    return Text(
      widget.item.condition == true ? 'New' : 'Used',
      style: CustomTextStyles.labelLargeBluegray400,
    );
  }

  /// Section Widget
  Widget _buildPrice(BuildContext context) {
    return Text(
      '${widget.item.Price} L.E',
      style: CustomTextStyles.labelLargeBluegray400,
    );
  }

  /// Section Widget
  Widget _buildAccept3(BuildContext context) {
    return Expanded(
        child: CustomElevatedButton(
            onPressed: () async {
              await ApisMethods.responseRequest(
                  widget.RequestID, token!, 'accepted');
            },
            height: 40.v,
            text: "Accept",
            margin: EdgeInsets.only(right: 4.h),
            leftIcon: Container(
                margin: EdgeInsets.only(right: 8.h),
                child: CustomImageView(
                    imagePath: ImageConstant.imgIconparksolidcorrect,
                    height: 15.adaptSize,
                    width: 15.adaptSize)),
            buttonStyle: CustomButtonStyles.fillGreenA));
  }

  /// Section Widget
  Widget _buildReject3(BuildContext context) {
    return Expanded(
        child: CustomOutlinedButton(
            onPressed: () async {
              await ApisMethods.responseRequest(
                  widget.RequestID, token!, 'rejected');
            },
            text: "Reject",
            margin: EdgeInsets.only(left: 4.h),
            leftIcon: Container(
                margin: EdgeInsets.only(right: 8.h),
                child: CustomImageView(
                    imagePath: ImageConstant.imgVaadinclose,
                    height: 12.adaptSize,
                    width: 12.adaptSize)),
            buttonTextStyle: CustomTextStyles.titleMediumPrimary));
  }

  /// Section Widget
  Widget _buildBtns(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildAccept3(context), _buildReject3(context)]);
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft1(BuildContext context) {
    Navigator.pop(context);
  }
}
