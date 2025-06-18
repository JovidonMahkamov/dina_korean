import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowWidget extends StatelessWidget {
  final IconData? icon;
  final String start_text;
  final String end_text;

  RowWidget({required this.icon, required this.start_text, required this.end_text});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 5.w),
        Text(
          start_text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        Expanded(child: SizedBox()),
        Text(
          end_text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}