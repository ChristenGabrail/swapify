import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import '../../../api/apimethods.dart';
import '../../../main.dart';

// ignore: must_be_immutable
class FavouritesItemWidget extends StatelessWidget {
  FavouritesItemWidget(
      {Key? key,
      this.condition,
      this.Name,
      this.price,
      this.onTapCard,
      required this.id,
      required this.imageUrl,
      required this.onsaved})
      : super(
          key: key,
        );

  VoidCallback? onTapCard;
  String? condition;
  String? Name;
  int? price;
  String imageUrl;
  String id;
  Function? onsaved;
  String? token = sharedPreferences.getString('token');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.h, 5.v, 5.h, 4.v),
      decoration: AppDecoration.outlineBluegray4001,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 119.v,
            width: 265.h,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                GestureDetector(
                  onTap: () {
                    onTapCard!.call();
                  },
                  child: CachedNetworkImage(
                    imageUrl: '${imageUrl.trim()}',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 119.v,
                    width: 265.h,
                    alignment: Alignment.center,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 211.h,
                      right: 8.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 54.v),
                        Container(
                          width: 46.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.h,
                            vertical: 1.v,
                          ),
                          decoration: AppDecoration.outlineBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder5,
                          ),
                          child: Text(
                            condition!,
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
          SizedBox(height: 14.v),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3.h),
                      child: Text(
                        Name!,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.h),
                      child: Text(
                        "${price!} L.E",
                        style: CustomTextStyles.labelLargePrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                    onPressed: () {
                      onsaved!();
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: ApisMethods.favoritesID.contains(id)
                          ? Colors.red
                          : Colors.grey,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
