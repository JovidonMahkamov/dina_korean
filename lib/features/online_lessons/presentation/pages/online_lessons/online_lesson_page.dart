import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dina_korean_real/core/route/route_names.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/course_entity.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/course_event.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/online_lesson/course_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/online_lesson/course_state.dart';

class OnlineLessonPage extends StatefulWidget {
  const OnlineLessonPage({super.key});

  @override
  State<OnlineLessonPage> createState() => _OnlineLessonPageState();
}

class _OnlineLessonPageState extends State<OnlineLessonPage> {
  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(CourseE());
  }

  Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final hasInternet = await checkInternetConnection();
          if (hasInternet) {
            context.read<CourseBloc>().add(CourseE());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Internet mavjud emas!"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kurslar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Sizda mavjud bo'lgan kurslar",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
                  ),
                  Divider(thickness: 2.0.h),
                  SizedBox(height: 5.h),
                  BlocBuilder<CourseBloc, CourseState>(
                    builder: (context, state) {
                      if (state is CourseLoading) {
                        return Column(
                          children: List.generate(3, (_) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 200.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          )),
                        );
                      } else if (state is CourseSuccess) {
                        final List<CourseEntity> result = state.course;
                        return Column(
                          children: result.map((course) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.onlineLessonOnTap,
                                  arguments: course,
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1.2.w),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                      child: CachedNetworkImage(
                                        imageUrl: course.previewImage,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 180.h,
                                        placeholder: (context, url) => Container(
                                          color: Colors.grey[300],
                                          height: 180.h,
                                        ),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Text(
                                        course.title,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else if (state is CourseError) {
                        return Center(child: Text(state.message));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
