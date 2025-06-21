import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Container1Widget extends StatefulWidget {
  final List<Map<dynamic,dynamic>> dataPaths;
  const Container1Widget({super.key,required this.dataPaths});

  @override
  State<Container1Widget> createState() => _Container1WidgetState();
}

class _Container1WidgetState extends State<Container1Widget> {


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
      widget.dataPaths.map((data) {
        final String imageUrl = data['imageUrl']!;
        final String title = data['title']!;
        final String nextUrl = data['nextUrl']??'';
        final Uri _dino_korean = Uri.parse(nextUrl);
        Future<void> _openDinaKorean() async {
          if (!await launchUrl(_dino_korean, mode: LaunchMode.externalApplication)) {
            throw 'Web Sayt ochilmadi: $_dino_korean';
          }
        }
        return GestureDetector(
          onTap: _openDinaKorean,
          child: Container(
            height: 400.h,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
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
                    child: Image.network(
                      imageUrl.toString(),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 500.h,
                      // gaplessPlayback: true,
                    ),
                  ),
                ),
                SizedBox(height: 25.h,),
                Text(title,style: TextStyle(fontSize: 16.sp),)
              ],
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 400.h,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
      ),
    );
  }
}
