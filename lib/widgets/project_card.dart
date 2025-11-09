import 'package:flutter/material.dart';
import 'package:my_portfolio/config/app_colors.dart';
import 'package:my_portfolio/config/app_constants.dart';
import 'package:my_portfolio/utils/screen_utils.dart';
import 'package:my_portfolio/widgets/app_button.dart';

class ProjectCardAction {
  final String title;
  final String? icon;
  final VoidCallback? onTap;

  ProjectCardAction({required this.title, this.icon, this.onTap});
  ProjectCardAction.web({required this.title, required this.onTap})
      : icon = "assets/icons/web_icon.svg";
  ProjectCardAction.android({required this.title, required this.onTap})
      : icon = "assets/icons/android_icon.svg";
  ProjectCardAction.ios({required this.title, required this.onTap})
      : icon = "assets/icons/apple_icon.svg";
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    this.image,
    this.actions = const [],
    this.textAlign = TextAlign.start,
  });
  final String title;
  final String description;
  final String? image;

  final TextAlign textAlign;
  final List<ProjectCardAction> actions;
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
                    SizedBox(
                      height: AdaptiveConstants.getSmallSpacing(context),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        spacing: AdaptiveConstants.getSmallSpacing(context),
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: actions.map((action) {
                          if (textAlign == TextAlign.center) {
                            return Expanded(
                              child: AppButton(
                                onPressed: action.onTap!,
                                title: action.title,
                                icon: action.icon,
                              ),
                            );
                          }
                          return AppButton(
                            onPressed: action.onTap!,
                            title: action.title,
                            icon: action.icon,
                          );
                        }).toList(),
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
