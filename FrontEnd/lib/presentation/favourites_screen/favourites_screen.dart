import 'package:christine_s_application20/api/apimethods.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import '../../main.dart';
import '../../models/itemModel.dart';
import '../item_screen/item_screen.dart';
import 'widgets/favourites_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore_for_file: must_be_immutable
class FavouritesScreen extends StatefulWidget {
  FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  String? token = sharedPreferences.getString('token');

  late List<Item> savedItems;
  bool is_loading_item = true;

  @override
  void initState() {
    super.initState();
    getitem();
  }

  Future<void> getitem() async {
    savedItems = await ApisMethods.getFAV(token!);
    setState(() {
      is_loading_item = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                  height: 1.v,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color:
                          theme.colorScheme.primaryContainer.withOpacity(1))),
              is_loading_item
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : savedItems.isEmpty
                      ? Center(child: Text('Saved items list is empty'))
                      : _buildFavourites(context)
            ]),
          )),
    ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: AppbarTitle(
            text: "Favourites", margin: EdgeInsets.only(left: 16.h)),
        styleType: Style.bgOutline);
  }

  /// Section Widget
  Widget _buildFavourites(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 42.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.v);
            },
            itemCount: savedItems.length,
            itemBuilder: (context, index) {
              return FavouritesItemWidget(
                  id: savedItems[index]!.ItemID,
                  imageUrl: savedItems[index]!.image,
                  Name: savedItems[index]!.Title,
                  condition:
                      savedItems[index]!.condition == true ? "New" : "Used",
                  price: savedItems[index]!.Price,
                  onsaved: () {
                    ApisMethods.DeletefromSaved(
                        token, savedItems[index].ItemID);
                    setState(() {
                      ApisMethods.favoritesID.remove(savedItems[index].ItemID);
                    });
                  },
                  onTapCard: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemScreen(id: savedItems[index].ItemID)));
                  });
            }));
  }
}
