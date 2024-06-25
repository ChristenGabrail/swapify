import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/core/app_export.dart';
import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/itemModel.dart';

// ignore_for_file: must_be_immutable
class ExchangeProcessScreen extends StatefulWidget {
  final String id;
  ExchangeProcessScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ExchangeProcessScreen> createState() => _ExchangeProcessScreenState();
}

class _ExchangeProcessScreenState extends State<ExchangeProcessScreen> {
  TextEditingController inputController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  String? token = sharedPreferences.getString('token');

  Item? _item;
  bool _isLoading = true;

  Future<void> getitem() async {
    _item = await ApisMethods.getitembyID(widget.id);
    setState(() {
      _isLoading = false;
    });
  }

  late List<Item> _Items;
  bool is_loading = true;
  Item? selectedItem;

  @override
  void initState() {
    super.initState();
    getitems();
    getitem();
  }

  Future<void> getitems() async {
    _Items = (await ApisMethods.getitemsforoneuser(token));
    setState(() {
      is_loading = false;
    });
  }

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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 1.v,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer
                                    .withOpacity(1))),
                        SizedBox(height: 68.v),
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : _buildThirteen(context),
                        SizedBox(height: 15.v),
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : _buildProductInfo(context),
                        SizedBox(height: 17.v),
                        Padding(
                            padding: EdgeInsets.only(left: 22.h),
                            child: Text("Description",
                                style: theme.textTheme.titleMedium)),
                        SizedBox(height: 2.v),
                        Padding(
                            padding: EdgeInsets.only(left: 22.h, right: 32.h),
                            child: Text('${_item?.Description}')),
                        SizedBox(height: 25.v),
                        Padding(
                            padding: EdgeInsets.only(left: 22.h),
                            child: Text("Exchange with",
                                style: theme.textTheme.titleMedium)),
                        SizedBox(height: 14.v),
                        is_loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : _buildFirstRow(context),
                        SizedBox(height: 16.v),
                        CustomElevatedButton(
                            text: "Request to Exchange",
                            onPressed: selectedItem == null
                                ? null
                                : () async {
                                    await ApisMethods.request(
                                        widget.id, selectedItem!.ItemID, token);
                                  },
                            margin: EdgeInsets.symmetric(horizontal: 16.h),
                            buttonTextStyle: CustomTextStyles
                                .titleSmallInterPrimaryContainer,
                            alignment: Alignment.center)
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
        title: AppbarTitle(
            text: "${_item?.Title}", margin: EdgeInsets.only(left: 16.h)),
        styleType: Style.bgOutline);
  }

  /// Section Widget
  Widget _buildThirteen(BuildContext context) {
    return SizedBox(
        height: 216.v,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.topRight, children: [
          CachedNetworkImage(
            imageUrl: '${_item?.image.trim()}',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: 216.v,
            width: 360.h,
            alignment: Alignment.center,
          ),
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
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${_item?.Title}",
                            style: theme.textTheme.bodyLarge),
                        SizedBox(height: 3.v),
                        Text("${_item?.Price} L.E",
                            style: CustomTextStyles.titleMediumPrimary)
                      ]),
                  Padding(
                      padding: EdgeInsets.only(top: 4.v, bottom: 32.v),
                      child:
                          _item?.condition == true ? Text("New") : Text("Used"))
                ])));
  }
/*
  /// Section Widget
  Widget _buildFirstRow(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _Items.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.only(left: 22.h, right: 34.h),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItem = _Items[index];
                  });
                },
                child: Container(
                  color: selectedItem == _Items[index]
                      ? Colors.lightBlueAccent.withOpacity(0.3)
                      : Colors.transparent,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCardToExchange(context,
                            conditionUsed: _Items[index].condition == true
                                ? "New"
                                : "Used",
                            lapTop: _Items[index].Title,
                            lECounter: "${_Items[index].Price} L.E"),
                      ]),
                ),
              ));
        });
  }
*/

  /// Section Widget
  Widget _buildFirstRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22.h, right: 34.h),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Spacing between columns
          mainAxisSpacing: 10.0, // Spacing between rows
          childAspectRatio: 3 / 4, // Aspect ratio of each item
        ),
        itemCount: _Items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedItem = _Items[index];
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedItem == _Items[index]
                    ? Colors.lightBlueAccent.withOpacity(0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15.h),
                border: Border.all(
                  color: selectedItem == _Items[index]
                      ? Colors.blueAccent
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: _buildCardToExchange(
                context,
                image: _Items[index].image,
                conditionUsed: _Items[index].condition == true ? "New" : "Used",
                lapTop: _Items[index].Title,
                lECounter: "${_Items[index].Price} L.E",
              ),
            ),
          );
        },
      ),
    );
  }

  /// Common widget
  Widget _buildCardToExchange(
    BuildContext context, {
    required String conditionUsed,
    required String lapTop,
    required String lECounter,
    required String image,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          height: 119.v,
          width: 123.h,
          child: Stack(alignment: Alignment.bottomRight, children: [
            CachedNetworkImage(
              imageUrl: '${image.trim()}',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 119.v,
              width: 123.h,
              alignment: Alignment.center,
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    width: 50.h,
                    margin: EdgeInsets.only(right: 6.h, bottom: 8.v),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 1.v),
                    decoration: AppDecoration.outlineBlueGray.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder5),
                    child: Text(conditionUsed,
                        style: CustomTextStyles.bodySmallGray5002
                            .copyWith(color: appTheme.gray5002))))
          ])),
      SizedBox(height: 7.v),
      Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text(lapTop,
              style: CustomTextStyles.bodySmallTeal900
                  .copyWith(color: appTheme.teal900))),
      Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text(lECounter,
              style: CustomTextStyles.labelLargePrimary
                  .copyWith(color: theme.colorScheme.primary)))
    ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}


/*import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/itemModel.dart';

// ignore_for_file: must_be_immutable
class ExchangeProcessScreen extends StatefulWidget {
  final String id;
  ExchangeProcessScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ExchangeProcessScreen> createState() => _ExchangeProcessScreenState();
}

class _ExchangeProcessScreenState extends State<ExchangeProcessScreen> {
  TextEditingController inputController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  String? token = sharedPreferences.getString('token');

  Item? _item;
  bool _isLoading = true;

  Future<void> getitem() async {
    _item = await ApisMethods.getitembyID(widget.id);
    setState(() {
      _isLoading = false;
    });
  }

  late List<Item> _Items;
  bool is_loading = true;

  @override
  void initState() {
    super.initState();
    getitems();
    getitem();
  }

  Future<void> getitems() async {
    _Items = (await ApisMethods.getitemsforoneuser(token));
    setState(() {
      is_loading = false;
    });
  }

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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 1.v,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer
                                    .withOpacity(1))),
                        SizedBox(height: 68.v),
                        _buildThirteen(context),
                        SizedBox(height: 15.v),
                        _buildProductInfo(context),
                        SizedBox(height: 17.v),
                        Padding(
                            padding: EdgeInsets.only(left: 22.h),
                            child: Text("Description",
                                style: theme.textTheme.titleMedium)),
                        SizedBox(height: 2.v),
                        Padding(
                            padding: EdgeInsets.only(left: 22.h, right: 32.h),
                            child: Text('Description')),
                        SizedBox(height: 25.v),
                        Padding(
                            padding: EdgeInsets.only(left: 22.h),
                            child: Text("Exchange with",
                                style: theme.textTheme.titleMedium)),
                        SizedBox(height: 14.v),
                        is_loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : _buildFirstRow(context),
                        SizedBox(height: 16.v),
/*                        _buildSecondRow(context),
                        SizedBox(height: 48.v),*/
                        CustomElevatedButton(
                            text: "Request to Exchange",
                            onPressed: () async {
                              await ApisMethods.request(
                                  widget.id, _Items[0].ItemID, token);
                            },
                            margin: EdgeInsets.symmetric(horizontal: 16.h),
                            buttonTextStyle: CustomTextStyles
                                .titleSmallInterPrimaryContainer,
                            alignment: Alignment.center)
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
  Widget _buildThirteen(BuildContext context) {
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
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${_item?.Title}",
                            style: theme.textTheme.bodyLarge),
                        SizedBox(height: 3.v),
                        Text("${_item?.Price} L.E",
                            style: CustomTextStyles.titleMediumPrimary)
                      ]),
                  Padding(
                      padding: EdgeInsets.only(top: 4.v, bottom: 32.v),
                      child:
                          _item?.condition == true ? Text("New") : Text("Used"))
                ])));
  }

  /// Section Widget
  Widget _buildFirstRow(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true, // Add this line
        physics: NeverScrollableScrollPhysics(), // And this one
        itemCount: _Items.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.only(left: 22.h, right: 34.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCardToExchange(context,
                        conditionUsed:
                            _Items[index].condition == true ? "New" : "Used",
                        lapTop: _Items[index].Title,
                        lECounter: "${_Items[index].Price} L.E"),
                  ]));
        });
  }

/*  /// Section Widget
  Widget _buildSecondRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 22.h, right: 35.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardToExchange(context,
                  conditionUsed: "Used",
                  lapTop: "Lap top",
                  lECounter: "15000 L.E"),
              Container(
                  margin: EdgeInsets.only(bottom: 43.v),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.h, vertical: 46.v),
                  decoration: AppDecoration.fillCyan.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                            imagePath: ImageConstant.imgPlus,
                            height: 18.adaptSize,
                            width: 18.adaptSize,
                            margin: EdgeInsets.symmetric(vertical: 3.v)),
                        Padding(
                            padding: EdgeInsets.only(left: 10.h),
                            child: Text("Add Item",
                                style: CustomTextStyles.titleMediumGray5002))
                      ]))
            ]));
  }
*/
  /// Common widget
  Widget _buildCardToExchange(
    BuildContext context, {
    required String conditionUsed,
    required String lapTop,
    required String lECounter,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          height: 119.v,
          width: 123.h,
          child: Stack(alignment: Alignment.bottomRight, children: [
            CustomImageView(
                imagePath: ImageConstant.imgPic119x123,
                height: 119.v,
                width: 123.h,
                radius: BorderRadius.circular(15.h),
                alignment: Alignment.center),
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    width: 50.h,
                    margin: EdgeInsets.only(right: 6.h, bottom: 8.v),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 1.v),
                    decoration: AppDecoration.outlineBlueGray.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder5),
                    child: Text(conditionUsed,
                        style: CustomTextStyles.bodySmallGray5002
                            .copyWith(color: appTheme.gray5002))))
          ])),
      SizedBox(height: 7.v),
      Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text(lapTop,
              style: CustomTextStyles.bodySmallTeal900
                  .copyWith(color: appTheme.teal900))),
      Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text(lECounter,
              style: CustomTextStyles.labelLargePrimary
                  .copyWith(color: theme.colorScheme.primary)))
    ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
*/