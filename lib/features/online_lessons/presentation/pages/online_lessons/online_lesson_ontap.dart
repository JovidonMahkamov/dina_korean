import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dina_korean_real/core/common/colors/app_colors.dart';
import 'package:dina_korean_real/core/route/route_names.dart';
import 'package:dina_korean_real/features/online_lessons/domain/entities/course_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/course_event.dart';
import '../../bloc/online_lesson/course_bloc.dart';
import '../../widget/my_tile_card.dart';
import '../../widget/row_widget.dart';

class OnlineLessonOntapPage extends StatefulWidget {
  final CourseEntity course;

  const OnlineLessonOntapPage({super.key, required this.course});

  @override
  State<OnlineLessonOntapPage> createState() => _OnlineLessonOntapPageState();
}

class _OnlineLessonOntapPageState extends State<OnlineLessonOntapPage> {

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
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.course.title,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    maxLines: 2,
                    widget.course.description,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 10.h),
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: widget.course.previewImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180.h,
                      placeholder:
                          (context, url) =>
                          Container(color: Colors.grey[300], height: 180.h),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Text(
                        "Nimalarni O'rganasiz?",
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.course.learning.split(', ').length,
                        itemBuilder: (context, index) {
                          final item = widget.course.learning.split(', ')[index];
                          final parts = item.split(' - ');
                          final kr = parts[0];
                          final uz = parts.length > 1 ? parts[1] : '';

                          return ListTile(
                            dense: true,
                            leading: Icon(
                              Icons.verified_outlined,
                              color: Colors.blue,
                              size: 25.sp,
                            ),
                            title: Text(
                              '$kr - $uz',
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Kurs Malumotlari",
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.format_list_bulleted, size: 40.sp),
                              Text(
                                "Modullar",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "9 ta",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 25.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 40.sp,
                                  ),
                                  Text(
                                    "Davomiyligi",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "13:36",
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(width: 25.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.ondemand_video, size: 40.sp),
                              Text(
                                "Video Darslar",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "25 ta",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Divider(thickness: 2),
                      SizedBox(height: 25.h),
                      MyTileCard(
                        title: "Kirish",
                        items: [
                          VideoLesson(
                            text: "Intro",
                            duration: "1:00",
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      MyTileCard(
                        title: "1.Modul: Salomlashish",
                        items: [
                          VideoLesson(
                            text: "1-Dars",
                            duration: "1:02",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "2-Dars",
                            duration: "51:59",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "3-Dars. 1) 은/는 2)이에요/예요",
                            duration: "50:59",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "4-Dars. Ot 입니다 / Ot 입니까?",
                            duration: "19:47",
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      MyTileCard(
                        title: "2.Modul: Kundalik Hayot",
                        items: [
                          VideoLesson(
                            text: "5-Dars1)이/가 있어요/없어요 2)이/저/그거는",
                            duration: "26:12",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "6-Dars. Ot+주세요. Ot+ 하고,과,와",
                            duration: "28:56",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "9-Dars 여기가 이에요/예요 에 있어요/없어요",
                            duration: "29:27",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "10-Dars. 에 가요/ N+[앞,옆,되]",
                            duration: "23:46",
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      MyTileCard(
                        title: "3.Modul: Kunlar va Pul birlik",
                        items: [
                          VideoLesson(
                            text: "7-Dars.Fe'l sifat 아/어요 Ot+ 을/를",
                            duration: "52:18",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "8-Dars 에서 - Dan,da / 안 - Emas",
                            duration: "33:18",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "12-Dars. Fe'l Sifat 았/었 - 고",
                            duration: "34:14",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "13-Dars Sonlar/ Fe'l + (으)세요",
                            duration: "29:20",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "14-Dars. Ot 이/가 Sifat 아/어요",
                            duration: "35:12",
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      MyTileCard(
                        title: "4-Modul: Havo, Vaqt va Kino",
                        items: [
                          VideoLesson(
                            text: "11-Dars. Raqam , Hafta kunlari",
                            duration: "53:42",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: '15 Dars "ㅂ- 불규칙" / 지만',
                            duration: "35:39",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: '16-Dars. 고 , ㅂ니다/습니다',
                            duration: "34:04",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: '17-Dars. "ㄷ" 불규칙 / (으)ㄹ까요',
                            duration: "33:36",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: '18-Dars [이,그,저] / 네요',
                            duration: "23:18",
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      MyTileCard(
                        title: "5-Modul: Vaqt va Reja",
                        items: [
                          VideoLesson(
                            text: "19-Dars Ot-의, [잘 (하다)못 하다]",
                            duration: "31:17",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "20-Dars. (이)세요/세요 , (으)시",
                            duration: "31:37",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "21-Dars. Vaqt [부터 , 까지]",
                            duration: "27:19",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: "22-Dars. F+아서/어서 , -(으) ㄹ 거예요",
                            duration: "26:26",
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      MyTileCard(
                        title: "6.Modul: Salomatlik va Aloqa",
                        items: [
                          VideoLesson(
                            text: '23-Dars. "(으)-탈락" / F+지 마세요',
                            duration: "22:25",
                            onTap: () {},
                          ),
                          VideoLesson(
                            text: '24-Dars. "만" / 아/어 야 돼요',
                            duration: "21:59",
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      MyTileCard(title: "7.Modul: Sayohat va Yo'l", items: []),
                      SizedBox(height: 5.h),
                      MyTileCard(title: "8.Modul: Rejalar va Orzular", items: []),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15.h,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.isDark ? Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Talablar",
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(widget.course.requirements,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15.h,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.isDark ? Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        context.isDark
                            ? BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 4,
                          // soft blur
                          offset: Offset(0, 7),
                        )
                            : BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          // light white shadow
                          blurRadius: 10,
                          // soft blur
                          offset: Offset(0, 4), // shadow direction: bottom
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${widget.course.currentPrice} UZS",
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              "${widget.course.oldPrice} UZS",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: Size(double.infinity, 40.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context,
                                RouteNames.onlineLessonDetail,arguments: widget.course
                            );
                          },
                          child: Center(
                            child: Text(
                              "Kursni ko'rish",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color:
                                context.isDark ? Colors.white : Colors.black,
                              ),
                            ), // Text
                          ), // Center
                        ),
                        SizedBox(height: 8.h),
                        RowWidget(
                          icon: Icons.ondemand_video_outlined,
                          start_text: "Darslar",
                          end_text: "25",
                        ),
                        Divider(color: Colors.grey),
                        RowWidget(
                          icon: Icons.watch_later_outlined,
                          start_text: "Davomiyligi",
                          end_text: "13:36",
                        ),
                        Divider(color: Colors.grey),
                        RowWidget(
                          icon: Icons.bar_chart_rounded,
                          start_text: "Darajasi",
                          end_text: widget.course.level,
                        ),
                        Divider(color: Colors.grey),
                        RowWidget(
                          icon: Icons.translate,
                          start_text: "Til",
                          end_text: widget.course.language,
                        ),
                        Divider(color: Colors.grey),
                        RowWidget(
                          icon: Icons.power_outlined,
                          start_text: "Kategoriya",
                          end_text: widget.course.category,
                        ),
                        Divider(color: Colors.grey),
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.infinity, size: 18.sp),
                            SizedBox(width: 10.w),
                            Text(
                              "Bir umr kirish",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              "Ha",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Divider(),
                  SizedBox(height: 15.h),
                  Text(
                    "Barcha Kurslar",
                    style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: context.isDark ? Color(0xFF1E293B) : Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/online_lessons/Dina_4.png"),
                        Divider(),
                        Text(
                          "Topik.Di",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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
