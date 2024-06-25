import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/presentation/published_update_screen/published_update_screen.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import 'package:get/get.dart';
import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/itemModel.dart';
import '../published_tab_container_screen/published_tab_container_screen.dart';

// ignore_for_file: must_be_immutable
class PublishedPage extends StatefulWidget {
  const PublishedPage({Key? key})
      : super(
          key: key,
        );

  @override
  PublishedPageState createState() => PublishedPageState();
}

class PublishedPageState extends State<PublishedPage>
    with AutomaticKeepAliveClientMixin<PublishedPage> {
  String? token = sharedPreferences.getString('token');

  late List<Item> UserItems;
  bool is_loading_item = true;

  @override
  void initState() {
    super.initState();
    getitem();
  }

  Future<void> getitem() async {
    UserItems = await ApisMethods.getitemsforoneuser(token!);
    setState(() {
      is_loading_item = false;
    });
    print('${UserItems} finalyyyyyy');
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 27.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 9.h),
                        child: Text(
                          "Published items",
                          style: CustomTextStyles.bodyLargePrimary,
                        ),
                      ),
                      SizedBox(height: 24.v),
                      is_loading_item
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : _buildCard2(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEdit1(BuildContext context, String id) {
    return Expanded(
      child: CustomElevatedButton(
        height: 30.v,
        text: "Edit",
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PublishedUpdateScreen(id: id)),
          );
        }),
        margin: EdgeInsets.only(right: 5.h),
        buttonStyle: CustomButtonStyles.fillPrimaryTL5,
        buttonTextStyle: CustomTextStyles.titleSmallPrimaryContainer,
      ),
    );
  }

  /// Section Widget
  Widget _buildRemove1(BuildContext context, itemID) {
    return Expanded(
      child: CustomElevatedButton(
        height: 30.v,
        text: "Remove",
        margin: EdgeInsets.only(left: 5.h),
        onPressed: () async {
          await ApisMethods.deleteItem(token!, itemID);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PublishedTabContainerScreen()));
        },
        buttonStyle: CustomButtonStyles.fillRedTL5,
        buttonTextStyle: CustomTextStyles.titleSmallPrimaryContainer,
      ),
    );
  }

  Widget _buildCard2(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.h, 8.v, 8.h, 7.v),
      decoration: AppDecoration.outlineBluegray4001,
      child: SizedBox(
          width: 500, // Make sure this width makes sense in your layout
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: UserItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCardPic(
                      context,
                      imageUrl: UserItems[index].image,
                      conditionNew:
                          UserItems[index].condition == true ? "New" : "Used",
                    ),
                    SizedBox(height: 7.v),
                    Padding(
                      padding: EdgeInsets.only(left: 3.h),
                      child: Text(
                        UserItems[index].Title,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.h),
                      child: Text(
                        "${UserItems[index].Price} L.E",
                        style: CustomTextStyles.labelLargePrimaryBold,
                      ),
                    ),
                    SizedBox(height: 9.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildEdit1(context, UserItems[index].ItemID),
                        _buildRemove1(context, UserItems[index].ItemID),
                      ],
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

// Common widget
  Widget _buildCardPic(
    BuildContext context, {
    required String conditionNew,
    required String imageUrl,
  }) {
    return SizedBox(
      height: 136.v,
      width: 288.h,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CachedNetworkImage(
            imageUrl: '${imageUrl.trim()}',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: 136.v,
            width: 288.h,
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 46.h,
              margin: EdgeInsets.only(
                right: 13.h,
                bottom: 8.v,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 5.h,
                vertical: 1.v,
              ),
              decoration: AppDecoration.outlineBlueGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder5,
              ),
              child: Text(
                conditionNew,
                style: CustomTextStyles.bodySmallGray5002.copyWith(
                  color: appTheme.gray5002,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
