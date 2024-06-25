import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/itemModel.dart';
import '../../widgets/custom_search_view.dart';
import '../item_screen/item_screen.dart';
import 'widgets/electronicscat_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class ItemsCategoryPage extends StatefulWidget {
  final String CategoryID;
  const ItemsCategoryPage({Key? key, required this.CategoryID})
      : super(key: key);

  @override
  items_category_pageState createState() => items_category_pageState();
}

class items_category_pageState extends State<ItemsCategoryPage>
    with AutomaticKeepAliveClientMixin<ItemsCategoryPage> {
  @override
  bool get wantKeepAlive => true;
  TextEditingController searchController = TextEditingController();

  String? token = sharedPreferences.getString('token');

  late List<Item> CategoryItems;
  bool is_loading_item = true;
  List<Item> searched_item = [];

  void clear() {
    setState(() {
      searched_item = [];
    });
  }

  void search(String? value) {
    setState(() {
      searched_item = CategoryItems.where(
          (element) => element.Title.toLowerCase().startsWith(value!)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getCategoryItems();
    GETFAV();
  }

  Future<void> getCategoryItems() async {
    CategoryItems =
        await ApisMethods.getItemsOFCategory(token!, widget.CategoryID);
    setState(() {
      is_loading_item = false;
    });
  }

  Future<void> GETFAV() async {
    await ApisMethods.getFAV(token!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                  is_loading_item
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : _buildElectronicsCat(context)
                ]))));
  }

  /// Section Widget
  Widget _buildElectronicsCat(BuildContext context) {
    final acceptedItems =
        CategoryItems.where((item) => item.status == "accepted").toList();

    final acceptedItems_search =
        acceptedItems.where((item) => item.status == "accepted").toList();

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
                    itemCount: acceptedItems_search.length,
                    itemBuilder: (context, index) {
                      return ElectronicscatItemWidget(
                          onsaved: () {
                            ApisMethods.favoritesID.contains(
                                    acceptedItems_search[index].ItemID)
                                ? ApisMethods.DeletefromSaved(
                                    token!, acceptedItems_search[index].ItemID)
                                : ApisMethods.AddtoSaved(
                                    token!, acceptedItems_search[index].ItemID);
                            setState(() {
                              ApisMethods.favoritesID.contains(
                                      acceptedItems_search[index].ItemID)
                                  ? ApisMethods.favoritesID.remove(
                                      acceptedItems_search[index].ItemID)
                                  : ApisMethods.favoritesID
                                      .add(acceptedItems_search[index].ItemID);
                            });
                          },
                          image: acceptedItems_search[index].image,
                          id: acceptedItems_search[index].ItemID,
                          title: acceptedItems_search[index].Title,
                          condition:
                              acceptedItems_search[index].condition == true
                                  ? 'New'
                                  : 'Used',
                          price: acceptedItems_search[index].Price,
                          onTapCardRec: () {
                            onTapCardRec(
                                context, acceptedItems_search[index].ItemID);
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
                    itemCount: acceptedItems.length,
                    itemBuilder: (context, index) {
                      return ElectronicscatItemWidget(
                          onsaved: () {
                            ApisMethods.favoritesID
                                    .contains(acceptedItems[index].ItemID)
                                ? ApisMethods.DeletefromSaved(
                                    token!, acceptedItems[index].ItemID)
                                : ApisMethods.AddtoSaved(
                                    token!, acceptedItems[index].ItemID);
                            setState(() {
                              ApisMethods.favoritesID
                                      .contains(acceptedItems[index].ItemID)
                                  ? ApisMethods.favoritesID
                                      .remove(acceptedItems[index].ItemID)
                                  : ApisMethods.favoritesID
                                      .add(acceptedItems[index].ItemID);
                            });
                          },
                          image: acceptedItems[index].image,
                          id: acceptedItems[index].ItemID,
                          title: acceptedItems[index].Title,
                          condition: acceptedItems[index].condition == true
                              ? 'New'
                              : 'Used',
                          price: acceptedItems[index].Price,
                          onTapCardRec: () {
                            onTapCardRec(context, acceptedItems[index].ItemID);
                          });
                    })));
  }

  /// Navigates to the itemScreen when the action is triggered.
  onTapCardRec(BuildContext context, String id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ItemScreen(id: id)));
  }
}
