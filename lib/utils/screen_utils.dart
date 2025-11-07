import 'package:flutter/widgets.dart';

class ScreenUtils {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  const ScreenUtils._();

  static Size screenSize(BuildContext context) => MediaQuery.sizeOf(context);

  static double screenWidth(BuildContext context) => screenSize(context).width;

  static double screenHeight(BuildContext context) =>
      screenSize(context).height;

  static bool isMobile(BuildContext context) =>
      screenWidth(context) < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      screenWidth(context) >= tabletBreakpoint;

  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? desktop;
    return desktop;
  }

  static EdgeInsets horizontalPadding(
    BuildContext context, {
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    final value = responsiveValue<double>(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
    return EdgeInsets.symmetric(horizontal: value);
  }

  static double constrainedWidth(
    BuildContext context, {
    required double maxWidth,
    required double mobileHorizontalPadding,
    double? tabletHorizontalPadding,
    required double desktopHorizontalPadding,
  }) {
    final horizontalPadding = responsiveValue<double>(
      context,
      mobile: mobileHorizontalPadding,
      tablet: tabletHorizontalPadding,
      desktop: desktopHorizontalPadding,
    );

    final totalPadding =
        (horizontalPadding * 2).clamp(0, double.infinity) as double;

    final rawWidth = screenWidth(context) - totalPadding;
    final availableWidth = rawWidth < 0 ? 0.0 : rawWidth;

    return availableWidth < maxWidth ? availableWidth : maxWidth;
  }
}
