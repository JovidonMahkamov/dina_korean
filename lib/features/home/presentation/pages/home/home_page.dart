import 'package:dina_korean_real/core/common/colors/app_colors.dart';
import 'package:dina_korean_real/features/home/widgets/home/app_bar.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
    );
  }
}
