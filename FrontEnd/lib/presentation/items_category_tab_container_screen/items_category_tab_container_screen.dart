import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_trailing_image.dart';
import 'package:christine_s_application20/presentation/items_category_page/items_category_page.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class ItemsCategoryTabContainerScreen extends StatefulWidget {
  final String CategoryName;
  final String CategoryID;
  const ItemsCategoryTabContainerScreen(
      {Key? key, required this.CategoryID, required this.CategoryName})
      : super(key: key);

  @override
  ItemsCategoryTabContainerScreenState createState() =>
      ItemsCategoryTabContainerScreenState();
}

// ignore_for_file: must_be_immutable
class ItemsCategoryTabContainerScreenState
    extends State<ItemsCategoryTabContainerScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: SizedBox(
          width: double.maxFinite,
          child: Column(children: [
            Container(
                height: 1.v,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(1))),
            SizedBox(height: 30.v),
            Expanded(child: SizedBox(height: 750.v, child: ItemsCategoryPage(CategoryID: widget.CategoryID )))
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
        title: AppbarTitle(
            text: "${widget.CategoryName}",
            margin: EdgeInsets.only(left: 16.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgSolarFilterLinear,
              margin: EdgeInsets.symmetric(horizontal: 36.h, vertical: 14.v),
              onTap: () {
                onTapSolarFilterLinear(context);
              })
        ],
        styleType: Style.bgOutline);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the filterCatScreen when the action is triggered.
  onTapSolarFilterLinear(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.filterCatScreen);
  }
}
