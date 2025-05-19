import 'package:dina_korean_real/core/common/colors/app_colors.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/statistic/statistic_bloc.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/statistic/statistic_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';


class StudentRatingWidget extends StatelessWidget {
  const StudentRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      height: 650.h,
      decoration: BoxDecoration(
        color: context.isDark ? const Color(0xFF1E293B) : Colors.white,
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

          /// BLOC BUILDER
          Expanded(
            child: BlocBuilder<StatisticBloc, StatisticState>(
              builder: (context, state) {
                if (state is StatisticLoading) {
                  return SizedBox(
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 33,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: (50),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is StatisticSuccess) {
                  final students = state.dashboardEntity.studentsWithProgress;
                  if (students.isEmpty) {
                    return const Center(child: Text("O'quvchilar topilmadi"));
                  }
                  return ListView.builder(
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
                                  Wrap(
                                    spacing: 7.w,
                                    children: [
                                      Text(
                                        student.firstName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      Text(
                                        student.lastName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    student.groupName.toString(),
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 9.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: context.isDark
                                    ? const Color(0xFF111827)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                "${student.progressPercentage.round()} %",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),

                            SizedBox(width: 8.w),
                            Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is StatisticError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text("Noma'lum xatolik yuz berdi"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
