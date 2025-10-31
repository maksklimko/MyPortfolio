import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/config/app_colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          width: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            "App Card",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).animate(target: 1.0).fadeIn(duration: Duration(milliseconds: 5000)),
        ),
      ],
    );
  }
}
