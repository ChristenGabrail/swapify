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

class suggestionsScreen extends StatefulWidget {
  const suggestionsScreen({Key? key}) : super(key: key);

  @override
  suggestionsScreen_pageState createState() => suggestionsScreen_pageState();
}

class suggestionsScreen_pageState extends State<suggestionsScreen>
    with AutomaticKeepAliveClientMixin<suggestionsScreen> {
  @override
  bool get wantKeepAlive => true;
  TextEditingController searchController = TextEditingController();

  String? token = sharedPreferences.getString('token');

  late List<Item> _Items;
  bool is_loading_Items = true;
  List<Item> searched_item = [];

  void clear() {
    setState(() {
      searched_item = [];
    });
  }

  void search(String? value) {
    setState(() {
      searched_item = _Items.where(
          (element) => element.Title.toLowerCase().startsWith(value!)).toList();
    });
  }

  Future<void> GETFAV() async {
    await ApisMethods.getFAV(token!);
  }

  Future<void> getitems() async {
    GETFAV();
    _Items = (await ApisMethods.getitems(token!));
    setState(() {
      is_loading_Items = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GETFAV();
    getitems();
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
                  is_loading_Items
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : _buildElectronicsCat(context)
                ]))));
  }

  /// Section Widget
  Widget _buildElectronicsCat(BuildContext context) {
    return searched_item.isNotEmpty
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
                    itemCount: searched_item.length,
                    itemBuilder: (context, index) {
                      return ElectronicscatItemWidget(
                          image: searched_item[index].image,
                          id: searched_item[index].ItemID,
                          title: searched_item[index].Title,
                          condition: searched_item[index].condition == true
                              ? 'New'
                              : 'Used',
                          price: searched_item[index].Price,
                          onTapCardRec: () {
                            onTapCardRec(context, searched_item[index].ItemID);
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
                    itemCount: _Items.length,
                    itemBuilder: (context, index) {
                      return ElectronicscatItemWidget(
                          image: _Items[index].image,
                          id: _Items[index].ItemID,
                          title: _Items[index].Title,
                          condition:
                              _Items[index].condition == true ? 'New' : 'Used',
                          price: _Items[index].Price,
                          onTapCardRec: () {
                            onTapCardRec(context, _Items[index].ItemID);
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
            text: "Suggestions", margin: EdgeInsets.only(left: 16.h)),
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

  /// Navigates to the filtersuggestionsScreen when the action is triggered.
  onTapSolarFilterLinear(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.filterRecentlyPostedScreen);
  }
}
