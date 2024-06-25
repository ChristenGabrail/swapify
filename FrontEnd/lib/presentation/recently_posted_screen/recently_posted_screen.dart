import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/itemModel.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';
import '../item_screen/item_screen.dart';
import '../items_category_page/widgets/electronicscat_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class RecentlyPostedScreen extends StatefulWidget {
  const RecentlyPostedScreen({Key? key}) : super(key: key);

  @override
  RecentlyPostedScreen_pageState createState() =>
      RecentlyPostedScreen_pageState();
}

class RecentlyPostedScreen_pageState extends State<RecentlyPostedScreen>
    with AutomaticKeepAliveClientMixin<RecentlyPostedScreen> {
  @override
  bool get wantKeepAlive => true;
  TextEditingController searchController = TextEditingController();

  String? token = sharedPreferences.getString('token');

  late List<Item> recent_Items;
  bool is_loading_recent = true;
  List<Item> searched_item_recent = [];
  @override
  void initState() {
    super.initState();
    GETFAV();
    recentPost();
  }

  Future<void> GETFAV() async {
    await ApisMethods.getFAV(token!);
  }

  void search(String? value) {
    setState(() {
      searched_item_recent = recent_Items
          .where((element) => element.Title.toLowerCase().startsWith(value!))
          .toList();
    });
  }

  void clear() {
    setState(() {
      searched_item_recent = [];
    });
  }

  Future<void> recentPost() async {
    GETFAV();
    recent_Items = (await ApisMethods.recentPost(token!));
    setState(() {
      is_loading_recent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.white,
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: CustomSearchView(
                          onChanged: ((p0) {
                            search(p0);
                          }),
                          clear: () {
                            clear();
                          },
                          controller: searchController,
                          hintText: "What are you looking for ?")),
                  SizedBox(height: 15.v),
                  is_loading_recent
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : _buildElectronicsCat(context)
                ]))));
  }

  /// Section Widget
  Widget _buildElectronicsCat(BuildContext context) {
    return searched_item_recent.isNotEmpty
        ? Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 44.h),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 164.v,
                        crossAxisCount: 2,
                        mainAxisSpacing: 24.h,
                        crossAxisSpacing: 24.h),
                    physics: BouncingScrollPhysics(),
                    itemCount: searched_item_recent.length,
                    itemBuilder: (context, index) {
                      return ElectronicscatItemWidget(
                          image: searched_item_recent[index].image,
                          id: searched_item_recent[index].ItemID,
                          title: searched_item_recent[index].Title,
                          condition:
                              searched_item_recent[index].condition == true
                                  ? 'New'
                                  : 'Used',
                          price: searched_item_recent[index].Price,
                          onTapCardRec: () {
                            onTapCardRec(
                                context, searched_item_recent[index].ItemID);
                          });
                    })))
        : Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 44.h),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 164.v,
                        crossAxisCount: 2,
                        mainAxisSpacing: 24.h,
                        crossAxisSpacing: 24.h),
                    physics: BouncingScrollPhysics(),
                    itemCount: recent_Items.length,
                    itemBuilder: (context, index) {
                      return ElectronicscatItemWidget(
                          image: recent_Items[index].image,
                          id: recent_Items[index].ItemID,
                          title: recent_Items[index].Title,
                          condition: recent_Items[index].condition == true
                              ? 'New'
                              : 'Used',
                          price: recent_Items[index].Price,
                          onTapCardRec: () {
                            onTapCardRec(context, recent_Items[index].ItemID);
                          });
                    })));
  }

  /// Navigates to the itemScreen when the action is triggered.
  onTapCardRec(BuildContext context, String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ItemScreen(id: id)));
  }

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
            text: "Recently posted", margin: EdgeInsets.only(left: 16.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgSolarFilterLinear,
              margin: EdgeInsets.symmetric(horizontal: 36.h, vertical: 14.v),
              onTap: () {
                onTapSolarFilterLinear(context);
              })
        ],
        styleType: Style.bgOutline_1);
  }

  // Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the filterRecentlyPostedScreen when the action is triggered.
  onTapSolarFilterLinear(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.filterRecentlyPostedScreen);
  }

  /*Widget searchBar() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: CustomSearchView(
            controller: searchController,
            hintText: "What are you looking for ?"));
  }*/
}
