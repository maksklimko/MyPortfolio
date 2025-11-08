import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/app_colors.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 25,
  });

  final VoidCallback onPressed;
  final String icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        icon,
        height: size,
        width: size,
      ),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.cardGradientStart,
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
