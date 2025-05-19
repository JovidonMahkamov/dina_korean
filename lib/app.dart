import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/dark_light/theme_changin.dart';
import 'core/route/route_generators.dart';
import 'core/route/route_names.dart';

class MyApp extends ConsumerWidget {
  final Box box;
  const MyApp({super.key,required this.box});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(backgroundColor: Color(0x8CFFFFFF)),
            scaffoldBackgroundColor: Color(0xFFE2E8F0),
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: ThemeData.light().textTheme.apply(
              bodyColor: Colors.black,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1F2937)),
            scaffoldBackgroundColor: Color(0xFF111827),
            iconTheme: IconThemeData(color: Colors.white),
            // Dark mode icon rangi
            textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white, // Dark mode yozuvlar rangi
            ),
          ),
          themeMode: ref.watch(themeProvider),
          initialRoute: RouteNames.splash,
          onGenerateRoute: AppRoute(context: context).onGenerateRoute,
        );
      },
    );
  }
}
