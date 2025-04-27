import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: SvgPicture.asset("assets/sign/dk.PNG"),
        actions: [
          FlutterSwitch(
            width: 70.0,
            height: 35.0,
            toggleSize: 30.0,
            value: isDarkMode,
            borderRadius: 20.0,
            padding: 2.0,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey.shade300,
            toggleColor: Colors.white,
            onToggle: (val) {
              setState(() {
                isDarkMode = val;
                // bu yerda dark/light mode theme almashasan
              });
            },
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            width: 70.w,
            height: 30.h,
            child: Center(child: Text("Kirish")),
          ),
        ],
      ),
    );
  }
}
