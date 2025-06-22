import 'package:carousel_slider/carousel_slider.dart';
import 'package:dina_korean_real/core/common/colors/app_colors.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/home_event.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/statistic/statistic_bloc.dart';
import 'package:dina_korean_real/features/home/presentation/bloc/statistic/statistic_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/dark_light/theme_changin.dart';
import '../../widgets/home/app_bar.dart';
import '../../widgets/home/home_listTiles.dart';
import '../../widgets/home/scroll_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Home_Page extends ConsumerStatefulWidget {
  const Home_Page({super.key});

  @override
  ConsumerState<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends ConsumerState<Home_Page> {
  final Uri _dino_korean = Uri.parse('https://dinakoreanmasterclass.uz');
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;
  bool isDarkMode = false;

  Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> _openDinaKorean() async {
    if (!await launchUrl(_dino_korean, mode: LaunchMode.externalApplication)) {
      throw 'Web Sayt ochilmadi: $_dino_korean';
    }
  }

  final List<Map<String, String>> _items = [
    {'image': 'assets/home/blue.png', 'title': 'Topik.Di Standart'},
    {'image': 'assets/home/purple.png', 'title': 'Topik.Di Premium'},
    {'image': 'assets/home/green.png', 'title': 'Topik.Di VIP'},
  ];
  bool isColor = true;

  @override
  void initState() {
    super.initState();
    context.read<StatisticBloc>().add(Statistic());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onToggle: (bool) {
          ref.read(themeProvider.notifier).toggleTheme();
          setState(() {
            isDarkMode = isColor;
          });
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final hasInternet = await checkInternetConnection();
          if (hasInternet) {
            context.read<StatisticBloc>().add(Statistic());
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xff6B5FF2), Color(0xffB13DE6)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12, // Shadow color
                        offset: Offset(0, 4), // Shadow position (x, y)
                        blurRadius: 8.r, // How much the shadow is spread out
                        spreadRadius: 3.r, // How far the shadow is spread
                      ),
                    ],
                  ),
                  height: 190.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ONLINE KURS",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        "Professional Online kurs bilan\nmahoratingizni oshiring",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffff8800),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          height: 40.h,
                          width: 150.w,
                          child: Row(
                            children: [
                              Text(
                                "Qo'shilish",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17.sp,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.black,
                                ),
                                radius: 17.r,
                              ),
                            ],
                          ),
                        ),
                        onTap: _openDinaKorean,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                BlocBuilder<StatisticBloc, StatisticState>(
                  builder: (context, state) {
                    if (state is StatisticLoading) {
                      return SizedBox(
                        height: 350,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: (70),
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
                      final statistics = state.dashboardEntity;
                      return Column(
                        children: [
                          HomeListTile(
                            iconAvatar: Icon(
                              IconlyLight.profile,
                              color: Colors.blueAccent.shade700,
                              size: 35.sp,
                            ),
                            title: "O'quvchilar",
                            subtitle: statistics.students.toString(),
                            circularColor:
                                context.isDark
                                    ? Colors.blueGrey
                                    : Color(0xFFE1F5FE),
                          ),
                          SizedBox(height: 20.h),
                          HomeListTile(
                            iconAvatar: Icon(
                              IconlyLight.user,
                              color: Colors.purpleAccent.shade700,
                              size: 35.sp,
                            ),
                            title: "Guruhlar",
                            subtitle: statistics.groups.toString(),
                            circularColor:
                                context.isDark
                                    ? Colors.blueGrey
                                    : Color(0xFFF3E5F5),
                          ),
                          SizedBox(height: 20.h),
                          HomeListTile(
                            iconAvatar: Icon(
                              IconlyLight.star,
                              color: Colors.green,
                              size: 35.sp,
                            ),
                            title: "Natijalar",
                            subtitle: statistics.results.toString(),
                            circularColor:
                                context.isDark
                                    ? Color(0xFF1B5E20)
                                    : Color(0xFFE1F4E2),
                          ),
                          SizedBox(height: 20.h),
                          HomeListTile(
                            iconAvatar: Icon(
                              IconlyBold.document,
                              color: Colors.green,
                              size: 35.sp,
                            ),
                            title: "Qo'llanmalar",
                            subtitle: '26',
                            circularColor:
                                context.isDark
                                    ? Color(0xFF1B5E20)
                                    : Color(0xFFE8F5E9),
                          ),
                        ],
                      );
                    } else if (state is StatisticError) {
                      return Center(child: Text(state.message));
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      "Yangiliklar",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            _controller.previousPage();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),

                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            _controller.nextPage();
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  height: 260.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.isDark ? Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: CarouselSlider.builder(
                    itemCount: _items.length,
                    carouselController: _controller,
                    itemBuilder: (context, index, realIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: Image.asset(
                              _items[index]['image']!,
                              height: 200.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            _items[index]['title']!,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: 240.h,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                StudentRatingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
