import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/models/itemModel.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../api/apimethods.dart';
import '../../main.dart';
import '../../widgets/custom_elevated_button.dart';
import '../chat_screen/chat_screen.dart';
import '../favourites_screen/widgets/favourites_item_widget.dart';
import '../item_screen/item_screen.dart';

// ignore_for_file: must_be_immutable
class SeeProfileScreen extends StatefulWidget {
  String id;
  String username;
  String city;
  String governorate;
  String image;

  SeeProfileScreen(
      {Key? key,
      required this.id,
      required this.city,
      required this.governorate,
      required this.image,
      required this.username})
      : super(key: key);

  @override
  State<SeeProfileScreen> createState() => _SeeProfileScreenState();
}

class _SeeProfileScreenState extends State<SeeProfileScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  String? token = sharedPreferences.getString('token');

  late List<Item> Items;
  bool is_loading = true;

  @override
  void initState() {
    super.initState();
    recentPost();
  }

  Future<void> GETFAV() async {
    await ApisMethods.getFAV(token!);
  }

  Future<void> recentPost() async {
    GETFAV();
    Items = (await ApisMethods.getitemsforuserbyid(widget.id));
    setState(() {
      is_loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: SizedBox(
            width: double.maxFinite,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  height: 1.v,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color:
                          theme.colorScheme.primaryContainer.withOpacity(1))),
              Padding(
                  padding: EdgeInsets.only(left: 28.h),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: '${widget.image.trim()}',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 71.v,
                        width: 69.h,
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 8.h, top: 12.v, bottom: 12.v),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.username}",
                                  style: theme.textTheme.titleMedium),
                              SizedBox(height: 4.v),
                              Text("Published items - 2",
                                  style: CustomTextStyles.bodySmallPrimary)
                            ])),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomElevatedButton(
                            height: 40,
                            text: "Chat",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          image: widget.image,
                                          reciverid: widget.id,
                                          reciverName: widget.username)));
                            },
                            buttonStyle: CustomButtonStyles.fillPrimaryTL5),
                      ),
                    )
                  ])),
              SizedBox(height: 8.v),
              Padding(
                  padding: EdgeInsets.only(left: 37.h),
                  child: Row(children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgMdiLocationRed400,
                        height: 20.adaptSize,
                        width: 20.adaptSize),
                    Text("${widget.city} , ${widget.governorate}",
                        style: theme.textTheme.bodySmall)
                  ])),
              SizedBox(height: 20.v),
              is_loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Items.isEmpty || Items == []
                      ? Center(
                          child: Text('NO Items Posted'),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.h),
                          child: _buildFavourites(context))
            ])),
      ),
    ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: double.maxFinite,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftTeal900,
            margin: EdgeInsets.fromLTRB(16.h, 14.v, 320.h, 14.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        styleType: Style.bgOutline);
  }
/*
  /// Common widget
  Widget _buildCard2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: Items.length,
        itemBuilder: ((context, index) {
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  height: 119.v,
                  width: 295.h,
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgPic,
                        height: 119.v,
                        width: 295.h,
                        radius: BorderRadius.circular(15.h),
                        alignment: Alignment.center),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            width: 50.h,
                            margin: EdgeInsets.only(right: 10.h, bottom: 11.v),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.h, vertical: 1.v),
                            decoration: AppDecoration.outlineBlueGray.copyWith(
                                borderRadius: BorderRadiusStyle.roundedBorder5),
                            child: Text(
                                Items[index]!.condition == true
                                    ? "New"
                                    : "Used",
                                style: CustomTextStyles.bodySmallGray5002
                                    .copyWith(color: appTheme.gray5002))))
                  ])),
              SizedBox(height: 16.v),
              Padding(
                  padding: EdgeInsets.only(left: 3.h),
                  child: Text(Items[index].Title,
                      style: theme.textTheme.labelLarge!
                          .copyWith(color: appTheme.teal900))),
              Padding(
                  padding: EdgeInsets.only(left: 3.h),
                  child: Text('${Items[index].Price}',
                      style: CustomTextStyles.labelLargePrimaryBold
                          .copyWith(color: theme.colorScheme.primary)))
            ]),
          );
        }),
      ),
    );
  }
*/

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
            itemCount: Items.length,
            itemBuilder: (context, index) {
              return FavouritesItemWidget(
                  id: Items[index]!.ItemID,
                  imageUrl: Items[index]!.image,
                  Name: Items[index]!.Title,
                  condition: Items[index]!.condition == true ? "New" : "Used",
                  price: Items[index]!.Price,
                  onsaved: () {
                    ApisMethods.favoritesID.contains(Items[index].ItemID)
                        ? ApisMethods.DeletefromSaved(
                            token!, Items[index].ItemID)
                        : ApisMethods.AddtoSaved(token!, Items[index].ItemID);
                    setState(() {
                      ApisMethods.favoritesID.contains(Items[index].ItemID)
                          ? ApisMethods.favoritesID.remove(Items[index].ItemID)
                          : ApisMethods.favoritesID.add(Items[index].ItemID);
                    });
                  },
                  onTapCard: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemScreen(id: Items[index].ItemID)));
                  });
            }));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
