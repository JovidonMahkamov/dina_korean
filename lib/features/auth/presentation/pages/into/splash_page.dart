import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/route/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RouteNames.signInPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 300.h,),
              Center(
                child: Image.asset(
                  "assets/sign/dk.PNG",
                  width: 150.w,
                  height: 150.h,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h,),
              Text('DinaKorean',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(
                height: 240.h,
              ),
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  colors: [Colors.white],
                  strokeWidth: 2,
                ),
              ),
            ],
          ),
        ) // Center
    ); // Scaffold
  }
}
