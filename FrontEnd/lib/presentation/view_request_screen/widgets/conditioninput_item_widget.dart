import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore: must_be_immutable
class ConditioninputItemWidget extends StatelessWidget {
  const ConditioninputItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 1.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "New",
        style: TextStyle(
          color: appTheme.gray5002,
          fontSize: 12.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
      selected: false,
      backgroundColor: theme.colorScheme.primary,
      selectedColor: theme.colorScheme.primaryContainer.withOpacity(1),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.blueGray400,
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
