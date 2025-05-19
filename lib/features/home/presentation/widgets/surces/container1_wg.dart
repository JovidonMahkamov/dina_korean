import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerWidget extends StatefulWidget {
  final List<Map<dynamic,dynamic>> dataPaths;
  const ContainerWidget({super.key,required this.dataPaths});

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
      widget.dataPaths.map((data) {
        final String path = data['path']!;
        final String title = data['title']!;
        return Container(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: 60,
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
                  child: Image.asset(
                    path.toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 600.h,
                  ),
                ),
              ),
              SizedBox(height: 25.h,),
              Text(title,style: TextStyle(fontSize: 16.sp),),
              SizedBox(height: 20.h,)
            ],
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 600.h,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
      ),
    );
  }
}
