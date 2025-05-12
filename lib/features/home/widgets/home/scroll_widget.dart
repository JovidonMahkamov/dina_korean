import 'package:dina_korean_real/core/common/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentRatingWidget extends StatelessWidget {
  final List<Map<String, String>> students = [
    {
      "name": "Umida Murodullayeva",
      "type": "Premium",
      "score": "59 %",
      "rank": "2",
    },
    {"name": "Shahzoda Ergasheva", "type": "VIP", "score": "56 %", "rank": "3"},
    {
      "name": "Asilbek O'Imasov",
      "type": "Premium",
      "score": "56 %",
      "rank": "4",
    },
    {"name": "Akbar Haydarov", "type": "Premium", "score": "56 %", "rank": "5"},
    {
      "name": "Mohinur Saparaliyeva",
      "type": "Premium",
      "score": "56 %",
      "rank": "6",
    },
    {
      "name": "Bekzod Barpiyev",
      "type": "Premium",
      "score": "53 %",
      "rank": "7",
    },
    {
      "name": "Dilmurod Hatamov",
      "type": "Premium",
      "score": "50 %",
      "rank": "8",
    },
    {
      "name": "Shokirkhon Rakhmatullakhonov",
      "type": "Premium",
      "score": "44 %",
      "rank": "9",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      height: 650.h,
      decoration: BoxDecoration(
        color: context.isDark ? Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Video darslardagi o'quvchilar reytingi !",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19.sp,
                color: Colors.blueGrey[600],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.yellow.shade700,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student["name"]!,

                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17.sp,
                              ),
                            ),
                            Text(
                              student["type"]!,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color:
                              context.isDark
                                  ? Color(0xFF111827)
                                  : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          student["score"]!,

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        student["rank"]!,

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
