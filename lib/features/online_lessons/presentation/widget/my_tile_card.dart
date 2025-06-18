import 'package:dina_korean_real/core/common/colors/app_colors.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTileCard extends StatelessWidget {
  final String title;
  final List<VideoLesson> items;

  const MyTileCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {

    return ExpansionTileCard(
      leading: Icon(
        Icons.expand_rounded,
        color: context.isDark ? Colors.white : Colors.black,
        size: 25.sp,
      ),
      baseColor: Colors.blue,
      expandedColor: Colors.blue,
      title: Text(
        title,
        style: TextStyle(color: context.isDark ? Colors.white : Colors.black, fontSize: 17.sp),
      ),
      children: items.map((item) {
        return GestureDetector(
          onTap: item.onTap,
          child: Container(
            height: 70.h,
            color: context.isDark ? const Color(0xFF121212) : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                children: [
                  Icon(Icons.videocam_outlined, size: 25.sp,),
                  SizedBox(width: 10.w),
                  Text(item.text, style: TextStyle(fontSize: 13.sp),),
                  Expanded(child: SizedBox()),
                  Text(item.duration, style: TextStyle(fontSize: 15.sp),),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class VideoLesson {
  final String text;
  final String duration;
  final VoidCallback? onTap;

  VideoLesson({
    required this.text,
    required this.duration,
    required this.onTap
  });
}