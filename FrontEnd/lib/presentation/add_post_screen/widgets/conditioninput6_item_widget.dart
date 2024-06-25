import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore: must_be_immutable
class Conditioninput6ItemWidget extends StatelessWidget {
  const Conditioninput6ItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 27.h,
        vertical: 3.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "New",
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
