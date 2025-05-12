import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../core/dark_light/theme_changin.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {

  void Function(bool) onToggle;
  MyAppBar({required this.onToggle});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Image.asset("assets/sign/dk.PNG", width: 40.w, height: 40.h),
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
          onToggle: onToggle,
        ),
        SizedBox(width: 15.w,)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
