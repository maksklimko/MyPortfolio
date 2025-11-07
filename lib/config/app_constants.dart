import 'package:flutter/material.dart';
import 'package:my_portfolio/utils/screen_utils.dart';

class AppConstants {
  static const double adaptiveWidthEdge = 700;
}

class AdaptiveConstants {
  static double getHeaderFontSize(BuildContext context) =>
      ScreenUtils.responsiveValue<double>(
        context,
        mobile: 32,
        desktop: 44,
      );

  static double getBodyFontSize(BuildContext context) =>
      ScreenUtils.responsiveValue<double>(
        context,
        mobile: 16,
        desktop: 20,
      );

  static double getCardBorderRadius(BuildContext context) =>
      ScreenUtils.responsiveValue<double>(
        context,
        mobile: 32,
        desktop: 60,
      );

  static double getSmallSpacing(BuildContext context) =>
      ScreenUtils.responsiveValue<double>(
        context,
        mobile: 10,
        desktop: 12,
      );

  static double getMediumSpacing(BuildContext context) =>
      ScreenUtils.responsiveValue<double>(
        context,
        mobile: 16,
        desktop: 20,
      );

  static double getLargeSpacing(BuildContext context) =>
      ScreenUtils.responsiveValue<double>(
        context,
        mobile: 30,
        desktop: 50,
      );
  static double getTextHeight(BuildContext context) =>
      ScreenUtils.responsiveValue<double>(
        context,
        mobile: 1.7,
        desktop: 2.0,
      );
}
