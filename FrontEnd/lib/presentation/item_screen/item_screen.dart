import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/models/itemModel.dart';
import 'package:christine_s_application20/models/userModel.dart';
import 'package:christine_s_application20/presentation/exchange_process_screen/exchange_process_screen.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/presentation/see_profile_screen/see_profile_screen.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/recommendation_model.dart';
import '../home_page/widgets/new_item_widget.dart';

// ignore_for_file: must_be_immutable
class ItemScreen extends StatefulWidget {
  final String id;

  ItemScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  Item? _item;
  bool _isLoading = true;

  User? _user;
  bool _isLoading_user = true;

  List<Recommendation>? _recommendation_items;
  bool recom_loading = true;

  @override
  void initState() {
    super.initState();
    initializeItem();
  }

  Future<void> initializeItem() async {
    _item = await ApisMethods.getitembyID(widget.id);
    if (_item != null) {
      _user = await ApisMethods.getuserinfoForItem(_item!.user_id);
      _recommendation_items =
          await ApisMethods.fetchRecommendations(_item!.Title.trim());

      setState(() {
        _isLoading = false;
        _isLoading_user = false;
        recom_loading = false;
      });
    }
  }

  TextEditingController inputController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
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
                        SizedBox(height: 15.v),
                        _buildEight(
                          context,
                          onsaved: () {
                            ApisMethods.favoritesID.contains(_item!.ItemID)
                                ? ApisMethods.DeletefromSaved(
                                    token!, _item!.ItemID)
                                : ApisMethods.AddtoSaved(token!, _item!.ItemID);
                            setState(() {
                              ApisMethods.favoritesID.contains(_item!.ItemID)
                                  ? ApisMethods.favoritesID
                                      .remove(_item!.ItemID)
                                  : ApisMethods.favoritesID.add(_item!.ItemID);
                            });
                          },
                        ),
                        SizedBox(height: 16.v),
                        _buildProductInfo(
                          context,
                          onsaved: () {
                            ApisMethods.favoritesID.contains(_item!.ItemID)
                                ? ApisMethods.DeletefromSaved(
                                    token!, _item!.ItemID)
                                : ApisMethods.AddtoSaved(token!, _item!.ItemID);
                            setState(() {
                              ApisMethods.favoritesID.contains(_item!.ItemID)
                                  ? ApisMethods.favoritesID
                                      .remove(_item!.ItemID)
                                  : ApisMethods.favoritesID.add(_item!.ItemID);
                            });
                          },
                        ),
                        SizedBox(height: 17.v),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 22.h),
                                child: Text("Description",
                                    style: theme.textTheme.titleMedium))),
                        SizedBox(height: 2.v),
                        Padding(
                            padding: EdgeInsets.only(left: 22.h, right: 32.h),
                            child: Text(
                              "${_item!.Description}",
                              maxLines: 4,
                            )),
                        SizedBox(height: 24.v),
                        _isLoading_user
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 22.h),
                                    child: Row(children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: '${_user!.image.trim()}',
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          height: 71.v,
                                          width: 69.h,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 8.h),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("${_user!.username}",
                                                    style: theme
                                                        .textTheme.titleMedium),
                                                SizedBox(height: 2.v),
                                                GestureDetector(
                                                    onTap: () {
                                                      onTapSeeProfile(context);
                                                    },
                                                    child: Row(children: [
                                                      Text("See Profile ",
                                                          style: CustomTextStyles
                                                              .bodySmallRed400),
                                                      CustomImageView(
                                                          imagePath: ImageConstant
                                                              .imgVector3Red400,
                                                          height: 8.v,
                                                          width: 4.h,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5.h,
                                                                  top: 5.v,
                                                                  bottom: 4.v))
                                                    ])),
                                                SizedBox(height: 3.v),
                                                Row(children: [
                                                  CustomImageView(
                                                      imagePath: ImageConstant
                                                          .imgMdiLocationRed400,
                                                      height: 20.adaptSize,
                                                      width: 20.adaptSize),
                                                  Text(
                                                      "${_user!.city} , ${_user!.governorate}",
                                                      style: theme
                                                          .textTheme.bodySmall)
                                                ])
                                              ]))
                                    ]))),
                        SizedBox(height: 40.v),
                        CustomElevatedButton(
                            text: "Request to Exchange",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ExchangeProcessScreen(
                                              id: widget.id)));
                            },
                            margin: EdgeInsets.symmetric(horizontal: 16.h),
                            buttonTextStyle: CustomTextStyles
                                .titleSmallInterPrimaryContainer),
                        SizedBox(height: 10.v),
                        recom_loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 22.h),
                                    child: Text("Recommendations",
                                        style: theme.textTheme.titleMedium))),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildNew_recom(context),
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
  Widget _buildEight(BuildContext context, {required onsaved}) {
    return SizedBox(
        height: 216.v,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.topRight, children: [
          CachedNetworkImage(
            imageUrl: '${_item!.image.trim()}',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: 216.v,
            width: 360.h,
            alignment: Alignment.center,
          ),
        ]));
  }

  /// Section Widget
  Widget _buildProductInfo(BuildContext context, {required onsaved}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("${_item?.Title}", style: theme.textTheme.bodyLarge),
                SizedBox(height: 2.v),
                Text("${_item?.Price} L.E",
                    style: CustomTextStyles.titleMediumPrimary)
              ]),
              Column(
                children: [
                  _item?.condition == true ? Text("New") : Text("Used"),
                  IconButton(
                      onPressed: () {
                        onsaved!();
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: ApisMethods.favoritesID.contains(_item!.ItemID)
                            ? Colors.red
                            : Colors.grey,
                      )),
                ],
              )
            ]));
  }

  /// Section Widget
  Widget _buildNew_recom(BuildContext context) {
    final acceptedItems = _recommendation_items!
        .where((item) => item.status == "accepted")
        .toList();

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 42.h),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 161.v,
                crossAxisCount: 2,
                mainAxisSpacing: 28.h,
                crossAxisSpacing: 28.h),
            physics: NeverScrollableScrollPhysics(),
            itemCount: acceptedItems.length,
            itemBuilder: (context, index) {
              return NewItemWidget(
                  id: acceptedItems[index].id,
                  imageUrl: acceptedItems[index].imageUrl,
                  name: acceptedItems[index].condition == true ? "New" : "Used",
                  title: acceptedItems[index].title,
                  price: acceptedItems[index].price,
                  onsaved: () {
                    ApisMethods.favoritesID.contains(acceptedItems![index].id)
                        ? ApisMethods.DeletefromSaved(
                            token!, acceptedItems[index].id)
                        : ApisMethods.AddtoSaved(
                            token!, acceptedItems[index].id);
                    setState(() {
                      ApisMethods.favoritesID.contains(acceptedItems[index].id)
                          ? ApisMethods.favoritesID
                              .remove(acceptedItems[index].id)
                          : ApisMethods.favoritesID
                              .add(acceptedItems[index].id);
                    });
                  },
                  onTapCardRec: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemScreen(id: acceptedItems[index].id)));
                  });
            }));
  }

  /// Common widget
  Widget _buildMakeup(
    BuildContext context, {
    required String makeup,
    Function? onTapMakeup,
  }) {
    return GestureDetector(
        onTap: () {
          onTapMakeup!.call();
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 5.v),
            decoration: AppDecoration.fillBlue
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 4.v),
                      child: Text(makeup,
                          style: CustomTextStyles
                              .titleMediumOnPrimaryContainer_1
                              .copyWith(
                                  color:
                                      theme.colorScheme.onPrimaryContainer))),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRight,
                      height: 13.v,
                      width: 6.h,
                      margin: EdgeInsets.symmetric(vertical: 7.v))
                ])));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the electronicsCatTabContainerScreen when the action is triggered.
  onTapElectronics(
    BuildContext,
  ) {}

  /// Navigates to the seeProfileScreen when the action is triggered.
  onTapSeeProfile(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SeeProfileScreen(
                  id: _user!.id,
                  username: _user!.username,
                  city: _user!.city,
                  governorate: _user!.governorate,
                  image: _user!.image,
                )));
  }
}
