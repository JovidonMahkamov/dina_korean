import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ElevatedWidget({super.key, required this.onPressed,required this.text});
  @override
  Widget build (BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        minimumSize: Size(double.infinity, 49.h),
      ),
      onPressed:onPressed,
      child:  Center(
        child: Text(
          text,
          style: const TextStyle (color: Colors.white),
        ), // Text
      ), // Center
    );
  }

}