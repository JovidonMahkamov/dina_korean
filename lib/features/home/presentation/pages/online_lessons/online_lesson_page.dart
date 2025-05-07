import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineLessonPage extends StatefulWidget {
  const OnlineLessonPage({super.key});

  @override
  State<OnlineLessonPage> createState() => _OnlineLessonPageState();
}

class _OnlineLessonPageState extends State<OnlineLessonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kurslar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
              ),
              SizedBox(height: 5.h,),
              Text(
                "Sizda mavjud bo'lgan kurslar",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
              ),
              Divider(
                thickness: 2.0.h,
              ),
              SizedBox(height: 5.h,),
              Image.asset('assets/sources/Dina_4.png')
            ],
          ),
        ),
      ),
    );
  }
}
