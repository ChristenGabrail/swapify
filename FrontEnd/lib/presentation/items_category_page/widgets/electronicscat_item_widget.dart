import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../../api/apimethods.dart';
import '../../../main.dart';

// ignore: must_be_immutable
class ElectronicscatItemWidget extends StatelessWidget {
  ElectronicscatItemWidget(
      {Key? key,
      this.onTapCardRec,
      required this.condition,
      required this.price,
      required this.title,
      required this.id,
      required this.image,
      this.onsaved})
      : super(
          key: key,
        );

  VoidCallback? onTapCardRec;
  String title;
  String id;
  int price;
  String condition;
  String image;
  Function? onsaved;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapCardRec?.call();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 119.v,
            width: 123.h,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                CachedNetworkImage(
                  imageUrl: '${image.trim()}',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 119.v,
                  width: 123.h,
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 71.h,
                      right: 6.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 65.v),
                        Container(
                          width: 46.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 1.v,
                          ),
                          decoration: AppDecoration.outlineBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder5,
                          ),
                          child: Text(
                            condition,
                            style: CustomTextStyles.bodySmallGray5002,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.v),
          Flexible(
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: Text(
                          title,
                          maxLines: 1,
                          style: CustomTextStyles.bodySmallTeal900,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: Text(
                          "$price L.E",
                          style: CustomTextStyles.labelLargePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      onsaved!();
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: ApisMethods.favoritesID.contains(id)
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
