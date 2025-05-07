import 'package:dina_korean_real/core/common/colors/app_colors.dart';
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
      padding: EdgeInsets.only(left: 15,),
      height: 90.h,
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
        color: context.isDark? Color(0xFF1E293B) // slate-800
          : Colors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            child: iconAvatar,
            backgroundColor: circularColor,
          ),
          SizedBox(width: 15.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: context.isDark? Colors.grey[300]: Colors.grey[600],
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  // color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
