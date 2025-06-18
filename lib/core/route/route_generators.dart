import 'package:dina_korean_real/core/route/route_names.dart';
import 'package:dina_korean_real/features/auth/presentation/pages/into/sign_in_page.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/course_entity.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/lesson_entity.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/pages/online_lessons/online_lesson_details.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/pages/online_lessons/online_lesson_ontap.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/into/splash_page.dart';
import '../../features/online_lessons/presentation/pages/online_lessons/audio_web_view_page.dart';
import '../../features/result/domain/entities/result.dart';
import '../../bottom_nav_bar.dart';
import '../../features/profile/domain/entities/profile.dart';
import '../../features/profile/presentation/pages/profile/edit_profile_page.dart';
import '../../features/profile/presentation/pages/profile/profile_page.dart';
import '../../features/result/presentation/pages/results/result_details_page.dart';

class AppRoute {
  BuildContext context;

  AppRoute({required this.context});

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteNames.signInPage:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case RouteNames.bottomNavBar:
        return MaterialPageRoute(builder: (_) => const BottomNavBarPage());
      case RouteNames.editProfile:
        final profile = routeSettings.arguments as Profile;
        return MaterialPageRoute(builder: (_) =>  EditProfilePage(profile: profile,));
      case RouteNames.resultDetailsPage:
        final result = routeSettings.arguments as Result;
        return MaterialPageRoute(builder: (_) =>  ResultDetailPage(result: result));
      case RouteNames.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case RouteNames.onlineLessonDetail:
        final courseId = routeSettings.arguments as CourseEntity;
        return MaterialPageRoute(builder: (_) =>  OnlineLessonDetails(courseId: courseId,));
      case RouteNames.onlineLessonOnTap:
        final course = routeSettings.arguments as CourseEntity;
        return MaterialPageRoute(builder: (_) =>  OnlineLessonOntapPage(course: course,));
      case RouteNames.audioWebViewPage:
        final url = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) =>  AudioWebViewPage(url: url));
      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Page not found')),
          ),
    );
  }
}
