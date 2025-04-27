import 'package:dina_korean_real/core/route/route_names.dart';
import 'package:dina_korean_real/features/auth/presentation/pages/into/sign_in_page.dart';
import 'package:dina_korean_real/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/into/splash_page.dart';

class AppRoute {
  BuildContext context;

  AppRoute({required this.context});

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteNames.signInPage:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case RouteNames.homePage:
        return MaterialPageRoute(builder: (_) => const Home_Page());
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
