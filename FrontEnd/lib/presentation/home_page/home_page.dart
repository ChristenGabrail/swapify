import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/presentation/categories_screen/categories_screen.dart';
import 'package:christine_s_application20/presentation/item_screen/item_screen.dart';
import 'package:christine_s_application20/presentation/profile_screen/profile_screen.dart';
import 'package:christine_s_application20/presentation/recently_posted_screen/recently_posted_screen.dart';
import 'package:christine_s_application20/presentation/suggestions_screen/suggestions_screen.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_trailing_image.dart';
import 'package:christine_s_application20/widgets/custom_search_view.dart';
import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/categoryModel.dart';
import '../../models/itemModel.dart';
import '../../models/userModel.dart';
import '../items_category_tab_container_screen/items_category_tab_container_screen.dart';
import 'widgets/home_item_widget.dart';
import 'widgets/new_item_widget.dart';
import 'widgets/used_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import 'package:christine_s_application20/presentation/logout_dialog/logout_dialog.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  String? token = sharedPreferences.getString('token');

  late List<Item> _Items;
  late List<CategoryModel> _Category;
  List<Item> searched_item = [];
  List<Item> searched_item_recent = [];
  bool is_loading = true;
  bool is_loading_item = true;
  late List<Item> recent_Items;
  bool is_loading_recent = true;

  User? _user;
  bool _isLoading_user = true;

  Future<void> getuser() async {
    _user = await ApisMethods.getuserinfo(token);

    print('user infooooooooo ${_user!}');
    setState(() {
      _isLoading_user = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getuser();
    getCategory();
    getitem();
    recentPost();
  }

  void search(String? value) {
    setState(() {
      searched_item = _Items.where(
          (element) => element.Title.toLowerCase().startsWith(value!)).toList();
      searched_item_recent = recent_Items
          .where((element) => element.Title.toLowerCase().startsWith(value!))
          .toList();
    });
  }

  Future<void> getCategory() async {
    _Category = (await ApisMethods.getAllCategories());
    setState(() {
      is_loading = false;
    });
  }

  Future<void> recentPost() async {
    GETFAV();
    recent_Items = (await ApisMethods.recentPost(token!));
    setState(() {
      is_loading_recent = false;
    });
  }

  Future<void> GETFAV() async {
    await ApisMethods.getFAV(token!);
  }

  Future<void> getitem() async {
    GETFAV();
    _Items = (await ApisMethods.getitems(token!));
    setState(() {
      is_loading_item = false;
    });
  }

  void clear() {
    setState(() {
      searched_item = [];
      searched_item_recent = [];
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
                        child: Column(children: [
                          Container(
                              height: 1.v,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer
                                      .withOpacity(1))),
                          SizedBox(height: 20.v),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 38.h),
                                  child: Text("Find the best",
                                      style: theme.textTheme.headlineMedium))),
                          SizedBox(height: 5.v),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 65.h),
                                  child: Text("Offer for you",
                                      style: theme.textTheme.headlineMedium))),
                          SizedBox(height: 26.v),
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
                          SizedBox(height: 44.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 27.h),
                              child: _buildHeader(context,
                                  recentlyPosted: "Categories",
                                  seeAll: "See all", onTapSeeAll: () {
                                onTapTxtSeeAll(context);
                              })),
                          SizedBox(height: 16.v),
                          is_loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _buildHome(context),
                          SizedBox(height: 43.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 27.h),
                              child: _buildHeader(context,
                                  recentlyPosted: "Recently posted",
                                  seeAll: "See all", onTapSeeAll: () {
                                onTapTxtSeeAll1(context);
                              })),
                          SizedBox(height: 16.v),
                          is_loading_recent
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _buildNew_recent(context),
                          SizedBox(height: 44.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 27.h),
                              child: _buildHeader(context,
                                  recentlyPosted: "Suggestions",
                                  seeAll: "See all", onTapSeeAll: () {
                                onTapTxtSeeAll2(context);
                              })),
                          SizedBox(height: 16.v),
                          is_loading_item
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _buildNew(context)
                        ]))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 61.v,
        leadingWidth: 52.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgBasilLogoutSolid,
            margin: EdgeInsets.only(left: 22.h, top: 7.v, bottom: 7.v),
            onTap: () {
              onTapBasilLogoutSolid(context);
            }),
        actions: [
          GestureDetector(
            onTap: () {
              onTapPlay(context);
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 23.h),
                child: _isLoading_user
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          height: 50.adaptSize,
                          imageUrl: '${_user!.image.trim()}',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )),
          ),
        ]);
  }

  /// Section Widget
  Widget _buildHome(BuildContext context) {
    return SizedBox(
        height: 87.v,
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 34.h),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(width: 16.h);
            },
            itemCount: _Category.length > 4 ? 4 : _Category.length,
            itemBuilder: (context, index) {
              return HomeItemWidget(
                  image: _Category[index].image,
                  text: _Category[index].Name,
                  onTapCardRec: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemsCategoryTabContainerScreen(
                                  CategoryID: _Category[index].CategoryModelID,
                                  CategoryName: _Category[index].Name,
                                )));
                  });
            }));
  }

  /// Section Widget
  Widget _buildNew(BuildContext context) {
    return searched_item.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.h),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 161.v,
                    crossAxisCount: 2,
                    mainAxisSpacing: 28.h,
                    crossAxisSpacing: 28.h),
                physics: NeverScrollableScrollPhysics(),
                itemCount: searched_item.length,
                itemBuilder: (context, index) {
                  return NewItemWidget(
                      id: searched_item[index].ItemID,
                      imageUrl: searched_item[index].image,
                      name: searched_item[index].condition == true
                          ? "New"
                          : "Used",
                      title: searched_item[index].Title,
                      price: searched_item[index].Price,
                      onsaved: () {
                        ApisMethods.favoritesID
                                .contains(searched_item[index].ItemID)
                            ? ApisMethods.DeletefromSaved(
                                token!, searched_item[index].ItemID)
                            : ApisMethods.AddtoSaved(
                                token!, searched_item[index].ItemID);
                        setState(() {
                          ApisMethods.favoritesID
                                  .contains(searched_item[index].ItemID)
                              ? ApisMethods.favoritesID
                                  .remove(searched_item[index].ItemID)
                              : ApisMethods.favoritesID
                                  .add(searched_item[index].ItemID);
                        });
                      },
                      onTapCardRec: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemScreen(
                                    id: searched_item[index].ItemID)));
                      });
                }))
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.h),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 161.v,
                    crossAxisCount: 2,
                    mainAxisSpacing: 28.h,
                    crossAxisSpacing: 28.h),
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return NewItemWidget(
                      id: _Items[index].ItemID,
                      imageUrl: _Items[index].image,
                      name: _Items[index].condition == true ? "New" : "Used",
                      title: _Items[index].Title,
                      price: _Items[index].Price,
                      onsaved: () {
                        ApisMethods.favoritesID.contains(_Items[index].ItemID)
                            ? ApisMethods.DeletefromSaved(
                                token!, _Items[index].ItemID)
                            : ApisMethods.AddtoSaved(
                                token!, _Items[index].ItemID);
                        setState(() {
                          ApisMethods.favoritesID.contains(_Items[index].ItemID)
                              ? ApisMethods.favoritesID
                                  .remove(_Items[index].ItemID)
                              : ApisMethods.favoritesID
                                  .add(_Items[index].ItemID);
                        });
                      },
                      onTapCardRec: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ItemScreen(id: _Items[index].ItemID)));
                      });
                }));
  }

  Widget _buildNew_recent(BuildContext context) {
    return searched_item_recent.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.h),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 161.v,
                    crossAxisCount: 2,
                    mainAxisSpacing: 28.h,
                    crossAxisSpacing: 28.h),
                physics: NeverScrollableScrollPhysics(),
                itemCount: searched_item_recent.length,
                itemBuilder: (context, index) {
                  return NewItemWidget(
                      id: searched_item_recent[index].ItemID,
                      imageUrl: searched_item_recent[index].image,
                      name: searched_item_recent[index].condition == true
                          ? "New"
                          : "Used",
                      title: searched_item_recent[index].Title,
                      price: searched_item_recent[index].Price,
                      onsaved: () {
                        ApisMethods.favoritesID
                                .contains(searched_item_recent[index].ItemID)
                            ? ApisMethods.DeletefromSaved(
                                token!, searched_item_recent[index].ItemID)
                            : ApisMethods.AddtoSaved(
                                token!, searched_item_recent[index].ItemID);
                        setState(() {
                          ApisMethods.favoritesID
                                  .contains(searched_item_recent[index].ItemID)
                              ? ApisMethods.favoritesID
                                  .remove(searched_item_recent[index].ItemID)
                              : ApisMethods.favoritesID
                                  .add(searched_item_recent[index].ItemID);
                        });
                      },
                      onTapCardRec: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemScreen(
                                    id: searched_item_recent[index].ItemID)));
                      });
                }))
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.h),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 161.v,
                    crossAxisCount: 2,
                    mainAxisSpacing: 28.h,
                    crossAxisSpacing: 28.h),
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return NewItemWidget(
                      id: recent_Items[index].ItemID,
                      imageUrl: recent_Items[index].image,
                      name: recent_Items[index].condition == true
                          ? "New"
                          : "Used",
                      title: recent_Items[index].Title,
                      price: recent_Items[index].Price,
                      onsaved: () {
                        ApisMethods.favoritesID
                                .contains(recent_Items[index].ItemID)
                            ? ApisMethods.DeletefromSaved(
                                token!, recent_Items[index].ItemID)
                            : ApisMethods.AddtoSaved(
                                token!, recent_Items[index].ItemID);
                        setState(() {
                          ApisMethods.favoritesID
                                  .contains(recent_Items[index].ItemID)
                              ? ApisMethods.favoritesID
                                  .remove(recent_Items[index].ItemID)
                              : ApisMethods.favoritesID
                                  .add(recent_Items[index].ItemID);
                        });
                      },
                      onTapCardRec: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemScreen(
                                    id: recent_Items[index].ItemID)));
                      });
                }));
  }

  /// Common widget
  Widget _buildHeader(
    BuildContext context, {
    required String recentlyPosted,
    required String seeAll,
    Function? onTapSeeAll,
  }) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recentlyPosted,
              style: CustomTextStyles.titleMedium18
                  .copyWith(color: appTheme.teal900)),
          GestureDetector(
              onTap: () {
                onTapSeeAll!.call();
              },
              child: Padding(
                  padding: EdgeInsets.only(top: 2.v, bottom: 6.v),
                  child: Text(seeAll,
                      style: theme.textTheme.labelLarge!.copyWith(
                          decoration: TextDecoration.underline,
                          color: appTheme.teal900))))
        ]);
  }

  /// Displays a dialog with the [LogoutDialog] content.
  onTapBasilLogoutSolid(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: LogoutDialog(),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.only(left: 0),
            ));
  }

  /// Navigates to the profileScreen when the action is triggered.
  onTapPlay(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  /// Navigates to the categoriesScreen when the action is triggered.
  onTapTxtSeeAll(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
  }

  /// Navigates to the recentlyPostedScreen when the action is triggered.
  onTapTxtSeeAll1(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RecentlyPostedScreen()));
  }

  /// Navigates to the recentlyPostedScreen when the action is triggered.
  onTapTxtSeeAll2(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => suggestionsScreen()));
  }

  /// Navigates to the itemScreen when the action is triggered.
  onTapCardRec(BuildContext context, String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ItemScreen(id: id)));
  }
}
