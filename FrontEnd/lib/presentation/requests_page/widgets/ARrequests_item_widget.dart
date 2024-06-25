import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/api/apimethods.dart';
import 'package:christine_s_application20/main.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore: must_be_immutable
class ARRequestsItemWidget extends StatelessWidget {
  ARRequestsItemWidget(
      {Key? key,
      required this.RequesterName,
      required this.firstItem,
      required this.secondItem,
      required this.image,
      required this.RequestID})
      : super(
          key: key,
        );

  VoidCallback? onTapViewItem;
  String RequesterName;
  String? image;
  String firstItem;
  String secondItem;
  String RequestID;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 7.v,
        bottom: 6.v,
      ),
      decoration: AppDecoration.outlineGray50,
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: '${image?.trim()}',
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: 48.adaptSize,
            width: 48.adaptSize,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                bottom: 1.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    RequesterName,
                    style: CustomTextStyles.titleSmallTeal900,
                  ),
                  SizedBox(height: 9.v),
                  SizedBox(
                    width: 190.h,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Sent you a request on your post\n",
                            style: CustomTextStyles.bodySmallff888888,
                          ),
                          TextSpan(
                            text: "“${firstItem}”\n",
                            style: CustomTextStyles.labelLargeff888888,
                          ),
                          TextSpan(
                            text: "with",
                            style: CustomTextStyles.bodySmallff888888,
                          ),
                          TextSpan(
                            text: " “${secondItem}”",
                            style: CustomTextStyles.labelLargeff888888,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
