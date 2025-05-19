import 'package:dina_korean_real/core/route/route_names.dart';
import 'package:dina_korean_real/features/auth/presentation/pages/into/sign_in_page.dart';
import 'package:dina_korean_real/features/home/presentation/pages/profile/edit_profile_page.dart';
import 'package:dina_korean_real/features/home/presentation/pages/profile/profile_page.dart';
import 'package:dina_korean_real/features/home/presentation/pages/results/result_details_page.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/into/splash_page.dart';
import '../../features/home/domain/entities/profile.dart';
import '../../features/home/domain/entities/result.dart';
import '../../features/home/presentation/pages/home/bottom_nav_bar.dart';

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
