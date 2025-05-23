import 'package:dina_korean_real/features/home/presentation/widgets/surces/string_wg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/surces/container1_widget.dart';
import '../../widgets/surces/container2_widget.dart';
import '../../widgets/surces/container_widget_source.dart';

class SourcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Drama va kinolar',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25.sp,
                  ),
                ),
                Text(
                  "Kino va drama orqali kores tilini o'rganamiz",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Divider(),
                SizedBox(height: 20.h),
                ContainerWidget(dataPaths: StringWg.dataPath),
                SizedBox(height: 30.h),
                Text(
                  'Foydali kanallar',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Koreys tili uchun foydali youtube kanallar',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Divider(),
                SizedBox(height: 20.h),
                Container1Widget(dataPaths: StringWg.dataPath1),
                SizedBox(height: 30.h),
                Text(
                  'Kitoblar',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Koreys tili va Topic uchun barcha kitoblar',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                Divider(),
                SizedBox(height: 20.h),
                Container2Widget(dataPaths: StringWg.dataPath1, path: 'path', title: 'title', urlSee: 'urlSee', urlSave: 'urlSave',)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
