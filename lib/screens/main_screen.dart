import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/config/app_colors.dart';
import 'package:my_portfolio/config/app_constants.dart';
import 'package:my_portfolio/utils/screen_utils.dart';
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
          _buildBackground().animate().fadeIn(duration: 500.milliseconds),
          _buildContent()
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final screenHeight = ScreenUtils.screenHeight(context);
    return SizedBox(
      height: screenHeight < 600 ? null : min(screenHeight, 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 3),
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
            )
                .animate()
                .fadeIn(duration: 1000.milliseconds, curve: Curves.easeOutCubic)
                .scaleXY(
                  begin: 0.92,
                  end: 1,
                  duration: 1000.milliseconds,
                  curve: Curves.easeOutBack,
                ),
          ),
          Spacer(flex: 2),
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
              )
                  .animate(delay: 200.milliseconds)
                  .fadeIn(duration: 1000.milliseconds, curve: Curves.easeOut)),
          Spacer(),
          Text(
            '''Experienced Flutter Developer with a background in Android development and three years of commercial experience specializing in cross-platform mobile app development. Collaborative and detail-oriented, driven by creating impactful apps that receive positive user feedback. Developed and delivered projects in healthcare, co-parenting, and booking systems''',
            style: TextStyle(
              color: Colors.white,
              height: AdaptiveConstants.getTextHeight(context),
              fontSize: AdaptiveConstants.getBodyFontSize(context),
              fontWeight: FontWeight.normal,
            ),
            textAlign: _getTextAlign(),
          )
              .animate(
                delay: 400.milliseconds,
              )
              .fadeIn(duration: 1000.milliseconds, curve: Curves.easeOut),
          Spacer(flex: 2),
          Row(
            mainAxisAlignment: ScreenUtils.isMobile(context)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            spacing: AdaptiveConstants.getMediumSpacing(context),
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
          )
              .animate(
                delay: 600.milliseconds,
              )
              .fadeIn(duration: 1000.milliseconds, curve: Curves.easeOut),
          Spacer(flex: 2),
          // Align(
          //   alignment: Alignment.center,
          //   child: Icon(
          //     Icons.keyboard_arrow_down_rounded,
          //     color: Colors.white,
          //     size: 60,
          //   )
          //       .animate(
          //         delay: 800.milliseconds,
          //         onPlay: (controller) => controller.repeat(reverse: true),
          //       )
          //       .fadeIn(
          //         duration: 1200.milliseconds,
          //         curve: Curves.easeOut,
          //       )
          //       .moveY(
          //         begin: -6,
          //         end: 6,
          //         duration: 1000.milliseconds,
          //         curve: Curves.easeInOut,
          //       ),
          // ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final projects = _buildProjects();
    final projectSpacing = AdaptiveConstants.getLargeSpacing(context);
    final endSpacing = AdaptiveConstants.getLargeSpacing(context);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildAdaptiveItem(_buildHeader()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final project = projects[index];
              final bottomPadding =
                  index < projects.length - 1 ? projectSpacing : endSpacing;

              return Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: _buildAdaptiveItem(project),
              );
            },
            childCount: projects.length,
            addAutomaticKeepAlives: true,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildProjects() {
    return [
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
      ProjectCard(
        title: "Habit tracking app",
        description:
            '''A sleek and intuitive app for building daily routines, featuring a captivating and complex start-screen animation to elevate user engagement.''',
        image: "assets/images/habit_tracker.jpg",
        textAlign: _getTextAlign(),
      ),
      ProjectCard(
        title: "Hostel booking",
        description:
            '''A user-friendly hostel booking app tailored for students, offering seamless navigation, real-time availability updates, and a streamlined booking experience''',
        image: "assets/images/hostel_booking.jpg",
        textAlign: _getTextAlign(),
      ),
      ProjectCard(
        title: "Timetravels PWA",
        description:
            '''Rebuilt the platform as a Progressive Web App with improved architecture, automated workflows, and an optimized tour builder for seamless use on desktop and mobile.''',
        image: "assets/images/pwa_app.jpg",
        textAlign: _getTextAlign(),
      ),
    ];
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
