import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/app_colors.dart';
import 'package:my_portfolio/utils/screen_utils.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.icon,
  });

  final VoidCallback onPressed;
  final String title;
  final String? icon;

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
    return ElevatedButton.icon(
      label: Text(title),
      icon: icon != null ? SvgPicture.asset(icon!, height: 20) : null,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.cardGradientStart,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
