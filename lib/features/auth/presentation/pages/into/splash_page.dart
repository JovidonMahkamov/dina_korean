import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/route/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _navigated = false;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _listenInternetChanges();
    _checkRealInternet();
  }


  Future<void> _checkRealInternet() async {
    final hasInternet = await _hasInternetConnection();
    if (!hasInternet) {
      _showNoInternetSnackBar();
    } else {
      _navigateToNextPage();
    }
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com')).timeout(const Duration(seconds: 5));
      return result.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  void _listenInternetChanges() {
    _subscription = Connectivity().onConnectivityChanged.listen((_) async {
      if (!_navigated) {
        final hasInternet = await _hasInternetConnection();
        if (hasInternet) {
          _navigateToNextPage();
        }
      }
    });
  }

  void _showNoInternetSnackBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Internet mavjud emas!"),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  Future<void> _navigateToNextPage() async {
    if (_navigated) return;
    _navigated = true;

    _subscription?.cancel();
    await Future.delayed(const Duration(seconds: 2));

    final box = await Hive.openBox('authBox');
    final token = box.get('token');
    final id = box.get('id');

    if (!mounted) return;

    if (token != null && token.toString().isNotEmpty &&
        id != null && id.toString().isNotEmpty) {
      Navigator.pushReplacementNamed(context, RouteNames.bottomNavBar);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.signInPage);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 300.h),
            Center(
              child: Image.asset(
                "assets/sign/dk.PNG",
                width: 150.w,
                height: 150.h,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'DinaKorean',
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 240.h),
            SizedBox(
              width: 60.w,
              height: 60.h,
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                colors: [Colors.white],
                strokeWidth: 2.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
