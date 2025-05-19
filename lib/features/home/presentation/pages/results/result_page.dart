import 'package:dina_korean_real/core/route/route_names.dart';
import 'package:dina_korean_real/features/home/domain/entities/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/home_event.dart';
import '../../bloc/result/result_bloc.dart';
import '../../bloc/result/result_state.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    context.read<ResultBloc>().add(ResultEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Natijalar',
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10.h),
              const Text(
                "Bizning o'qivchilarimiz olgan natijalari",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              const Divider(),
              Expanded(
                child: BlocBuilder<ResultBloc, ResultState>(
                  builder: (context, state) {
                    if (state is ResultLoading) {
                      return SizedBox(
                        height: 500,
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.all(8),
                                ),
                              ),
                            );
                          }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        ),
                      );
                    } else if (state is ResultSuccess) {
                      final List<Result> result = state.result;

                      return GridView.builder(
                        // padding: const EdgeInsets.all(8),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          final topik = result[index];
                          return GestureDetector(
                            onTap: (){Navigator.pushNamed(context, RouteNames.resultDetailsPage,arguments: topik);},
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      topik.img,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is ResultError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
