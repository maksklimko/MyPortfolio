import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/config/app_colors.dart';
import 'package:my_portfolio/config/app_constants.dart';
import 'package:my_portfolio/utils/screen_utils.dart';
import 'package:my_portfolio/widgets/animated_list_view.dart';
import 'package:my_portfolio/widgets/app_icon_button.dart';
import 'package:my_portfolio/widgets/project_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGradientStart,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _buildBackground().animate().fadeIn(duration: 300.milliseconds),
          _buildAnimatedListView()
        ],
      ),
    );
  }

  Widget _buildAnimatedListView() {
    return AnimatedListView(
      spacing: AdaptiveConstants.getLargeSpacing(context),
      items: [
        _buildAdaptiveItem(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AdaptiveConstants.getLargeSpacing(context) * 2),
              Align(
                alignment: ScreenUtils.isMobile(context)
                    ? Alignment.center
                    : Alignment.centerLeft,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/avatar.jpg",
                    width: _getImageSize(),
                    height: _getImageSize(),
                  ),
                ),
              ),
              SizedBox(height: AdaptiveConstants.getLargeSpacing(context)),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Hi, I'm Maks",
                  textAlign: _getTextAlign(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AdaptiveConstants.getHeaderFontSize(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: AdaptiveConstants.getMediumSpacing(context)),
              Text(
                '''Experienced Flutter Developer with a background in Android development and three years of commercial experience specializing in cross-platform mobile app development. Collaborative and detail-oriented, driven by creating impactful apps that receive positive user feedback. Developed and delivered projects in healthcare, co-parenting, and booking systems''',
                style: TextStyle(
                  color: Colors.white,
                  height: AdaptiveConstants.getTextHeight(context),
                  fontSize: AdaptiveConstants.getBodyFontSize(context),
                  fontWeight: FontWeight.normal,
                ),
                textAlign: _getTextAlign(),
              ),
              SizedBox(height: AdaptiveConstants.getLargeSpacing(context) * 2),
            ],
          ),
        ),
        _buildAdaptiveItem(
          Row(
            spacing: AdaptiveConstants.getSmallSpacing(context),
            children: [
              AppIconButton(
                onPressed: () {
                  launchUrl(Uri.parse(
                      "https://www.linkedin.com/in/maks-klimko-29ab071b0/"));
                },
                icon: "assets/icons/linkedin_icon.svg",
              ),
              AppIconButton(
                onPressed: () {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'maks.klmqaz@gmail.com',
                  );
                  launchUrl(emailLaunchUri);
                },
                icon: "assets/icons/mail_icon.svg",
              ),
            ],
          ),
        ),
        _buildAdaptiveItem(
          ProjectCard(
            title: "Eargym",
            description:
                '''A wellness platform focused on enhancing hearing health through innovative auditory exercises and engaging user experiences''',
            image: "assets/images/eargym.jpg",
            actions: [
              ProjectCardAction(
                title: "Website",
                onTap: () => launchUrl(Uri.parse("https://www.eargym.world/")),
              ),
            ],
            textAlign: _getTextAlign(),
          ),
        ),
        _buildAdaptiveItem(
          ProjectCard(
            title: "Habit tracking app",
            description:
                '''A sleek and intuitive app for building daily routines, featuring a captivating and complex start-screen animation to elevate user engagement.''',
            image: "assets/images/habit_tracker.jpg",
            textAlign: _getTextAlign(),
          ),
        ),
        _buildAdaptiveItem(
          ProjectCard(
            title: "Hostel booking",
            description:
                '''A user-friendly hostel booking app tailored for students, offering seamless navigation, real-time availability updates, and a streamlined booking experience''',
            image: "assets/images/hostel_booking.jpg",
            textAlign: _getTextAlign(),
          ),
        ),
        _buildAdaptiveItem(
          ProjectCard(
            title: "Timetravels PWA",
            description:
                '''Rebuilt the platform as a Progressive Web App with improved architecture, automated workflows, and an optimized tour builder for seamless use on desktop and mobile.''',
            image: "assets/images/pwa_app.jpg",
            textAlign: _getTextAlign(),
          ),
        ),
        SizedBox(height: AdaptiveConstants.getSmallSpacing(context)),
      ],
    );
  }

  TextAlign _getTextAlign() {
    return ScreenUtils.isMobile(context) ? TextAlign.center : TextAlign.start;
  }

  Widget _buildAdaptiveItem(Widget item) {
    final contentWidth = ScreenUtils.constrainedWidth(
      context,
      maxWidth: AppConstants.adaptiveWidthEdge,
      mobileHorizontalPadding: 20,
      desktopHorizontalPadding: 50,
    );

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: contentWidth,
        child: item,
      ),
    );
  }

  double _getImageSize() {
    return ScreenUtils.responsiveValue<double>(
      context,
      mobile: 200,
      desktop: 250,
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
}
