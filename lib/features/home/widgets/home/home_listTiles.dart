import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeListTile extends StatelessWidget {
  final Widget iconAvatar;
  final String title;
  final String subtitle;
  final Color circularColor;

  const HomeListTile({
    Key? key,
    required this.iconAvatar,
    required this.title,
    required this.subtitle,
    required this.circularColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Shadow color
            offset: Offset(0, 4), // Shadow position (x, y)
            blurRadius: 8, // How much the shadow is spread out
            spreadRadius: 3, // How far the shadow is spread
          ),
        ],
        color: Colors.white,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.r,
          child: iconAvatar,
          backgroundColor: circularColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
