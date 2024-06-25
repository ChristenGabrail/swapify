import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/itemModel.dart';

// ignore_for_file: must_be_immutable
class ItemHidedPage extends StatefulWidget {
  const ItemHidedPage({Key? key})
      : super(
          key: key,
        );

  @override
  ItemHidedPageState createState() => ItemHidedPageState();
}

class ItemHidedPageState extends State<ItemHidedPage>
    with AutomaticKeepAliveClientMixin<ItemHidedPage> {
  @override
  bool get wantKeepAlive => true;

  String? token = sharedPreferences.getString('token');

  List<Item>? _Items;
  bool is_loading_item = true;

  Future<void> getitem() async {
    _Items = (await ApisMethods.getExpiredItems(token!));
    setState(() {
      is_loading_item = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getitem();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.white,
          child: Column(
            children: [
              SizedBox(height: 27.v),
              is_loading_item
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : _buildEdit(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEdit(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 9.h),
            child: Text(
              "Exchaged items ",
              style: CustomTextStyles.bodyLargePrimary,
            ),
          ),
          SizedBox(height: 24.v),
          Container(
            padding: EdgeInsets.fromLTRB(8.h, 8.v, 8.h, 7.v),
            decoration: AppDecoration.outlineBluegray4001,
            child: SizedBox(
              height: 400, // You can adjust this value based on your needs
              child: ListView.separated(
                itemCount: _Items!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16.v);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    // Add a return statement here
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 136.v,
                        width: 288.h,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CachedNetworkImage(
                              imageUrl: '${_Items![index].image.trim()}',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                                decoration:
                                    AppDecoration.outlineBlueGray.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder5,
                                ),
                                child: Text(
                                  _Items![index].condition == true
                                      ? "New"
                                      : "Used",
                                  style: CustomTextStyles.bodySmallGray5002,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 7.v),
                      Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: Text(
                          "${_Items![index].Title}",
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: Text(
                          "${_Items![index].Price} L.E",
                          style: CustomTextStyles.labelLargePrimaryBold,
                        ),
                      ),
                      SizedBox(height: 9.v),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
