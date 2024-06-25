import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlue => BoxDecoration(
        color: appTheme.blue50.withOpacity(0.3),
      );
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray400.withOpacity(0.5),
      );
  static BoxDecoration get fillCyan => BoxDecoration(
        color: appTheme.cyan700,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray5002,
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red400,
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal900,
      );

  // Outline decorations
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: theme.colorScheme.primary,
        border: Border.all(
          color: appTheme.blueGray400,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBluegray400 => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray400,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBluegray4001 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray400,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineBluegray4002 => BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.blueGray400,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray5002,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray50 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray50,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray5002 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray5002,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: appTheme.gray5002,
      );
  static BoxDecoration get outlinePrimary1 => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineTeal => BoxDecoration(
        color: appTheme.blue50,
      );

  // White decorations
  static BoxDecoration get white => BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder24 => BorderRadius.circular(
        24.h,
      );
  static BorderRadius get circleBorder46 => BorderRadius.circular(
        46.h,
      );

  // Custom borders
  static BorderRadius get customBorderTL16 => BorderRadius.only(
        topLeft: Radius.circular(16.h),
        topRight: Radius.circular(16.h),
        bottomRight: Radius.circular(16.h),
      );
  static BorderRadius get customBorderTL161 => BorderRadius.only(
        topLeft: Radius.circular(16.h),
        topRight: Radius.circular(16.h),
        bottomLeft: Radius.circular(16.h),
      );
  static BorderRadius get customBorderTL20 => BorderRadius.vertical(
        top: Radius.circular(20.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder110 => BorderRadius.circular(
        110.h,
      );
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15.h,
      );
  static BorderRadius get roundedBorder34 => BorderRadius.circular(
        34.h,
      );
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.
    
// For Flutter SDK Version 3.7.2 or greater.
    
double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
    