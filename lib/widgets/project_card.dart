import 'package:flutter/material.dart';
import 'package:my_portfolio/config/app_colors.dart';
import 'package:my_portfolio/config/app_constants.dart';
import 'package:my_portfolio/utils/screen_utils.dart';

class ProjectCardAction {
  final String title;
  final VoidCallback? onTap;

  ProjectCardAction({required this.title, this.onTap});
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    this.image,
    this.actions,
    this.textAlign = TextAlign.start,
  });
  final String title;
  final String description;
  final String? image;

  final TextAlign textAlign;
  final List<ProjectCardAction>? actions;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
            ),
            borderRadius: BorderRadius.circular(
              AdaptiveConstants.getCardBorderRadius(context),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: _getContentPadding(context),
                child: Column(
                  spacing: AdaptiveConstants.getSmallSpacing(context),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        title,
                        textAlign: textAlign,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              AdaptiveConstants.getHeaderFontSize(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        description,
                        textAlign: textAlign,
                        style: TextStyle(
                          color: Colors.white,
                          height: AdaptiveConstants.getTextHeight(context),
                          fontSize: AdaptiveConstants.getBodyFontSize(context),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      AdaptiveConstants.getCardBorderRadius(context),
                    ),
                    bottomRight: Radius.circular(
                      AdaptiveConstants.getCardBorderRadius(context),
                    ),
                  ),
                  child: Image.asset(image!, fit: BoxFit.fitWidth),
                ),
            ],
          ),
        ),
      ],
    );
  }

  EdgeInsets _getContentPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: ScreenUtils.responsiveValue<double>(
        context,
        mobile: 20,
        desktop: 40,
      ),
      vertical: ScreenUtils.responsiveValue<double>(
        context,
        mobile: 20,
        desktop: 40,
      ),
    );
  }
}
