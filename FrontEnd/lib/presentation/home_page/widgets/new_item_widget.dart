import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/api/apimethods.dart';
import 'package:christine_s_application20/main.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore: must_be_immutable
class NewItemWidget extends StatelessWidget {
  NewItemWidget({
    Key? key,
    this.onTapCardRec,
    required this.title,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.id,
    required this.onsaved,
  }) : super(
          key: key,
        );

  final String title;
  final String name;
  final int price;
  final String imageUrl;
  VoidCallback? onTapCardRec;
  final String id;
  Function? onsaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 119.v,
          width: 123.h,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              GestureDetector(
                onTap: () {
                  onTapCardRec!.call();
                },
                child: CachedNetworkImage(
                  imageUrl: '${imageUrl.trim()}',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 119.v,
                  width: 123.h,
                  alignment: Alignment.center,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 71.h,
                    right: 6.h,
                  ),
                  child: Column(
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
                          "${name}",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: Text(
                          "${title}",
                          maxLines: 1,
                          style: CustomTextStyles.bodySmallTeal900,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.h),
                        child: Text(
                          "${price} L.E",
                          style: CustomTextStyles.labelLargePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
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
        ),
      ],
    );
  }
}
