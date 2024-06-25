import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/presentation/requests_page/Acceptedrequests_page.dart';
import 'package:christine_s_application20/presentation/requests_page/Panddingrequests_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:christine_s_application20/presentation/requests_page/Rejectedrequests_page.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class RequestsTabContainerScreen extends StatefulWidget {
  const RequestsTabContainerScreen({Key? key}) : super(key: key);

  @override
  RequestsTabContainerScreenState createState() =>
      RequestsTabContainerScreenState();
}

// ignore_for_file: must_be_immutable
class RequestsTabContainerScreenState extends State<RequestsTabContainerScreen>
    with TickerProviderStateMixin {
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
          child: Column(children: [
            Container(
                height: 1.v,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(1))),
            _buildTabview(context),
            SizedBox(
                height: 545.v,
                child: TabBarView(controller: tabviewController, children: [
                  PanddingRequestsPage(),
                  AcceptedRequestsPage(),
                  Rejectedrequests()
                ]))
          ])),
    ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 42.h,
        title:
            AppbarTitle(text: "Requests", margin: EdgeInsets.only(left: 16.h)),
        styleType: Style.bgOutline);
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return SizedBox(
        height: 25.v,
        width: 288.h,
        child: TabBar(
            controller: tabviewController,
            labelPadding: EdgeInsets.zero,
            labelColor: theme.colorScheme.primary,
            labelStyle: TextStyle(
                fontSize: 12.fSize,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
            unselectedLabelColor: appTheme.black900,
            unselectedLabelStyle: TextStyle(
                fontSize: 12.fSize,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400),
            indicatorColor: theme.colorScheme.primary,
            tabs: [
              Tab(child: Text("Pending")),
              Tab(child: Text("Accepted")),
              Tab(child: Text("Rejected"))
            ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
