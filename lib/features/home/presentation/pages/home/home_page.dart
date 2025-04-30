import 'package:carousel_slider/carousel_slider.dart';
import 'package:dina_korean_real/features/home/widgets/home/app_bar.dart';
import 'package:dina_korean_real/features/home/widgets/home/home_listTiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final Uri _dino_korean = Uri.parse('https://dinakoreanmasterclass.uz');
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;
  bool isDarkMode = false;

  Future<void> _openDinaKorean() async {
    if (!await launchUrl(_dino_korean, mode: LaunchMode.externalApplication)) {
      throw 'Web Sayt ochilmadi: $_dino_korean';
    }
  }
  final List<Map<String, String>> _items = [
    {
      'image': 'assets/home/blue.png',
      'title': 'Topik.Di Standart',
    },
    {
      'image': 'assets/home/purple.png',
      'title': 'Topik.Di Premium',
    },
    {
      'image': 'assets/home/green.png',
      'title': 'Topik.Di VIP',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xff6B5FF2),
                      Color(0xffB13DE6),
                      // #F3A1FF
                      // Color.fromARGB(255, 0, 0, 0),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12, // Shadow color
                      offset: Offset(0, 4), // Shadow position (x, y)
                      blurRadius: 8, // How much the shadow is spread out
                      spreadRadius: 3, // How far the shadow is spread
                    ),
                  ],
                ),
                height: 170.h,
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
                        padding: EdgeInsets.all(4.r),
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
                              child: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black,),
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
              // Container(
              //   height: 80.h,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(17.r),
              //   ),
              // ),
              HomeListTile(
                iconAvatar: Icon(
                  IconlyLight.profile,
                  color: Colors.blue,
                  size: 35.sp,
                ),
                title: "O'quvchilar",
                subtitle: "54",
                circularColor: Color(0xFFE1F5FE),
              ),
              SizedBox(height: 20.h),
              HomeListTile(
                iconAvatar: Icon(
                  IconlyLight.user,
                  color: Colors.purpleAccent,
                  size: 35.sp,
                ),
                title: "Guruhlar",
                subtitle: "4",
                circularColor: Color(0xFFF3E5F5),
              ),
              SizedBox(height: 20.h),
              HomeListTile(
                iconAvatar: Icon(
                  IconlyLight.star,
                  color: Colors.green,
                  size: 35.sp,
                ),
                title: "Natijalar",
                subtitle: "30",
                circularColor: Color(0xFFE1F4E2),
              ),
              SizedBox(height: 20.h),
              HomeListTile(
                iconAvatar: Icon(
                  IconlyBold.document,
                  color: Colors.green,
                  size: 35.sp,
                ),
                title: "Qo'llanmalar",
                subtitle: "26",
                circularColor: Color(0xFFE8F5E9),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    "Yangiliklar",
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        _controller.previousPage();
                      },
                      icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        _controller.nextPage();
                      },
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.all(15.w),
                height: 260.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    height: 240.h, // bu container ichidagi max balandlikka mos
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
              )

            ],
          ),
        ),
      ),
    );
  }
}
