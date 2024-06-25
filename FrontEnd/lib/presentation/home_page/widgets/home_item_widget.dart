import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class HomeItemWidget extends StatelessWidget {
  HomeItemWidget({
    Key? key,
    required this.text,
    this.onTapCardRec,
    required this.image,
  }) : super(
          key: key,
        );
  final String text;
  final VoidCallback? onTapCardRec;
  String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 61.h,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 61.adaptSize,
              width: 61.adaptSize,
              child: IconButton(
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: '${image.trim()}',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                onPressed: () {
                  onTapCardRec?.call();
                },
              ),
            ),
            SizedBox(height: 9.v),
            Text(
              "$text",
              style: CustomTextStyles.titleSmallSemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
