import 'package:dina_korean_real/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../core/dark_light/theme_changin.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Image.asset("assets/sign/dk.PNG", width: 40, height: 40),
      actions: [
        FlutterSwitch(
          width: 45.0,
          height: 25.0,
          toggleSize: 20.0,
          value: ref.watch(themeProvider) == ThemeMode.dark,
          borderRadius: 20.0,
          padding: 2.0,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey.shade300,
          toggleColor: Colors.white,
          activeIcon: Icon(Icons.dark_mode),
          inactiveIcon: Icon(Icons.sunny),
          onToggle: (value) {
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
        SizedBox(width: 15),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            width: 80,
            height: 35,
            child: Center(
              child: Text(
                "Kirish",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, RouteNames.signInPage);
          },
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
