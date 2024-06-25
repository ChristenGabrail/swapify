import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore: must_be_immutable
class ThirtysixItemWidget extends StatelessWidget {
  const ThirtysixItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 7.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "Electronics",
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontSize: 12.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
      selected: false,
      backgroundColor: theme.colorScheme.primaryContainer.withOpacity(1),
      selectedColor: theme.colorScheme.primaryContainer.withOpacity(1),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(
          5.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
