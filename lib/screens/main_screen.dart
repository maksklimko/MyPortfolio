import 'package:flutter/material.dart';
import 'package:my_portfolio/config/app_colors.dart';
import 'package:my_portfolio/widgets/animated_list_view.dart';
import 'package:my_portfolio/widgets/app_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [_buildBackground(), _buildAnimatedListView()]),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundGradientStart,
            AppColors.backgroundGradientEnd,
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedListView() {
    return AnimatedListView(
      spacing: 50,
      items: [AppCard(), AppCard(), AppCard(), AppCard(), AppCard(), AppCard()],
    );
  }
}
