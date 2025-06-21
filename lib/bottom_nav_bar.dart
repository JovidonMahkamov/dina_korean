import 'package:dina_korean_real/features/home/presentation/pages/sources/source_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'features/online_lessons/presentation/pages/online_lessons/online_lesson_page.dart';
import 'features/profile/presentation/pages/profile/profile_page.dart';
import 'features/home/presentation/pages/home/home_page.dart';
import 'features/result/presentation/pages/results/result_page.dart';
import 'package:flutter/widgets.dart';


class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  @override
  int _currentIndex = 0;
  List<Widget> pages =  [
    Home_Page(),
    OnlineLessonPage(),
    SourcePage(),
    ResultPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey[600],
          selectedItemColor: Colors.blueAccent,
          currentIndex: _currentIndex,
          selectedLabelStyle:
          TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItemWidget("Bosh sahifa", const Icon(IconlyLight.home)),
            BottomNavigationBarItemWidget("Online darslar", const Icon(IconlyLight.video)),
            BottomNavigationBarItemWidget("Manbalar", const Icon(IconlyLight.document)),
            BottomNavigationBarItemWidget("Natijalar", const Icon(IconlyLight.bookmark)),
            BottomNavigationBarItemWidget("Profil", const Icon(IconlyLight.profile)),
          ],
        ),
      ),
    );
  }

}

BottomNavigationBarItem BottomNavigationBarItemWidget(
    String label, Icon icon) {
  return BottomNavigationBarItem(
      // backgroundColor: Colors.white,
      label: label,
      icon: icon
  );
}
