import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/presentation/pendingPage/pending_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_trailing_image.dart';
import 'package:christine_s_application20/widgets/custom_icon_button.dart';
import 'package:christine_s_application20/presentation/published_page/published_page.dart';
import 'package:christine_s_application20/presentation/item_hided_page/item_hided_page.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../widgets/app_bar/buildLogo.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';

class PublishedTabContainerScreen extends StatefulWidget {
  const PublishedTabContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  PublishedTabContainerScreenState createState() =>
      PublishedTabContainerScreenState();
}

class PublishedTabContainerScreenState
    extends State<PublishedTabContainerScreen> with TickerProviderStateMixin {
  late TabController tabviewController;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 1.v,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color:
                              theme.colorScheme.primaryContainer.withOpacity(1),
                        ),
                      ),
                      Container(
                        height: 34.v,
                        width: 262.h,
                        margin: EdgeInsets.only(left: 41.h),
                        child: TabBar(
                          controller: tabviewController,
                          labelPadding: EdgeInsets.zero,
                          labelColor: theme.colorScheme.primary,
                          labelStyle: TextStyle(
                            fontSize: 16.fSize,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          unselectedLabelColor: appTheme.teal900,
                          unselectedLabelStyle: TextStyle(
                            fontSize: 16.fSize,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          indicatorColor: theme.colorScheme.primary,
                          tabs: [
                            Tab(
                              child: Text(
                                "Published",
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Pending",
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Exchaged",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 674.v,
                        child: TabBarView(
                          controller: tabviewController,
                          children: [
                            PublishedPage(),
                            pendingPage(),
                            ItemHidedPage(),
                          ],
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
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 42.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftTeal900,
            margin: EdgeInsets.only(left: 18.h, top: 14.v, bottom: 14.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarTitle(text: "Items", margin: EdgeInsets.only(left: 16.h)),
        styleType: Style.bgOutline);
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
