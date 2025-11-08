import 'package:flutter/material.dart';
import 'package:my_portfolio/config/app_colors.dart';
import 'package:my_portfolio/config/app_constants.dart';
import 'package:my_portfolio/utils/screen_utils.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onPressed, required this.title});
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      vertical: ScreenUtils.responsiveValue<double>(
        context,
        mobile: 20,
        desktop: 22,
      ),
      horizontal: ScreenUtils.responsiveValue<double>(
        context,
        mobile: 18,
        desktop: 24,
      ),
    );
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.cardGradientStart,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: AdaptiveConstants.getButtonFontSize(context),
        ),
      ),
    );
  }
}
