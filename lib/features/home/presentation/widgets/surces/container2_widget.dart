import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Container2Widget extends StatefulWidget {
  final List<Map<dynamic, dynamic>> dataPaths;
  final String path;
  final String title;
  final String urlSee;
  final String urlSave;

  const Container2Widget({super.key, required this.dataPaths, required this.path, required this.title, required this.urlSee, required this.urlSave});

  @override
  State<Container2Widget> createState() => _Container2WidgetState();
}

class _Container2WidgetState extends State<Container2Widget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
          widget.dataPaths.map((data) {
            final String path = data[widget.path]!;
            final String title = data[widget.title]!;
            final String urlSee = data[widget.urlSee] ?? '';
            final Uri _dino_korean = Uri.parse(urlSee);
            Future<void> _openDinaKorean() async {
              if (!await launchUrl(
                _dino_korean,
                mode: LaunchMode.externalApplication,
              )) {
                throw 'Web Sayt ochilmadi: $_dino_korean';
              }
            }
            final String urlSave = data[widget.urlSave] ?? '';
            final Uri _dino_korean1 = Uri.parse(urlSave);
            Future<void> _openDinaKorean1() async {
              if (!await launchUrl(
                _dino_korean1,
                mode: LaunchMode.externalApplication,
              )) {
                throw 'Web Sayt ochilmadi: $_dino_korean1';
              }
            }
            return Container(
              height: 400.h,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.r,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        path.toString(),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 500.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Text(title, style: TextStyle(fontSize: 16.sp)),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed:_openDinaKorean,
                        child: Row(
                          children: [
                            Icon(Icons.remove_red_eye_outlined),
                            SizedBox(width: 10.w),
                            Text("Ko'rish"),
                          ],
                        ),
                      ),
                      SizedBox(width: 25.w,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed:_openDinaKorean1,
                        child: Row(
                          children: [
                            Icon(Icons.save_alt),
                            SizedBox(width: 10.w),
                            Text("Yuklash"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
      options: CarouselOptions(
        height: 500.h,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
      ),
    );
  }
}
