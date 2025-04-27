import 'package:flutter/material.dart';
abstract class AppColors {
  static const Color secondary = Color(0xFFFFD300);
  static const primary = _PrimaryBlue();
  static const greyScale = _GreyScale();
  static const background = _Background();

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Color(0xFFF44336);
  static const Color pink = Color(0xFFE91E63);
  static const Color purple = Color(0xFF9C27B0);
  static const Color deepPurple = Color(0xFF673AB7);
  static const Color indigo = Color(0xFF3F51B5);
  static const Color blue = Color(0xFF2196F3);
  static const Color lightBlue = Color(0xFF03A9F4);
  static const Color cyan = Color(0xFF00BCD4);
  static const Color teal = Color(0xFF009688);
  static const Color green = Color(0xFF4CAF50);
  static const Color lightGreen = Color(0xFF8BC34A);
  static const Color lime = Color(0xFFCDDC39);
  static const Color yellow = Color(0xFFFFEB3B);
  static const Color amber = Color(0xFFFFC107);
  static const Color orange = Color(0xFFFF9800);
  static const Color deepOrange = Color(0xFFFF5722);
  static const Color brown = Color(0xFF795548);
  static const Color blueGrey = Color(0xFF607D8B);

  // Indicator Colors
  static const Color progressLow = Color(0xFF35DEBC); // 0-49%
  static const Color progressMediumLow = Color(0xFFFFE580); // 50-59%
  static const Color progressMediumHigh = Color(0xFFFFAB38); // 60-74%
  static const Color progressHigh = Color(0xFFFF4D67); // 75-99%
  static const Color progressComplete = Color(0xFF246BFD); // 100%
}

class _PrimaryBlue {
  const _PrimaryBlue();

  final blue100 = const Color(0xFFEBEFFE);
  final blue200 = const Color(0xFFADBFFC);
  final blue300 = const Color(0xFF859EFA);
  final blue400 = const Color(0xFF5C7EF9);
  final blue500 = const Color(0xFF335EF7);

  Color call() => blue500;
}

class _GreyScale {
  const _GreyScale();

  final Color grey900 = const Color(0xFF212121);
  final Color grey800 = const Color(0xFF424242);
  final Color grey700 = const Color(0xFF616161);
  final Color grey600 = const Color(0xFF757575);
  final Color grey500 = const Color(0xFF9E9E9E);
  final Color grey400 = const Color(0xFFBDBDBD);
  final Color grey300 = const Color(0xFFE0E0E0);
  final Color grey200 = const Color(0xFFEEEEEE);
  final Color grey100 = const Color(0xFFF5F5F5);
  final Color grey50 = const Color(0xFFFAFAFA);

}

class _Background {
  const _Background();

  final Color dark = const Color(0xFF181A20);
  final Color dark2 = const Color(0xFF1F222A);
  final Color dark3 = const Color(0xFF35383F);
  final Color blueAccent = const Color(0xFF335EF7);
}