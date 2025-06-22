import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/course_with_sections/course_with_sections_bloc.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/course_with_sections/course_with_sections_state.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/lesson_detail/lesson_detail_bloc.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/lesson_detail/lesson_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/route/route_names.dart';
import '../../../domain/entities/course_entity.dart';
import '../../../domain/entities/task_entity.dart';
import '../../bloc/course_event.dart';
import '../../widget/vimeo_wg.dart';

class OnlineLessonDetails extends StatefulWidget {
  final CourseEntity courseId;

  const OnlineLessonDetails({super.key, required this.courseId});

  @override
  State<OnlineLessonDetails> createState() => _OnlineLessonDetailsState();
}

class _OnlineLessonDetailsState extends State<OnlineLessonDetails> {
  List<TextEditingController> _controllers = [];
  List<bool> _isCorrectList = [];

  Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  void initState() {
    super.initState();
    context.read<CourseWithSectionsBloc>().add(
      CourseWithSectionE(courseId: widget.courseId),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool get allAnsweredCorrectly =>
      _isCorrectList.isNotEmpty && !_isCorrectList.contains(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
      ),
      drawer: Drawer(
        child: RefreshIndicator(
          onRefresh: () async {
            final hasInternet = await checkInternetConnection();
            if (hasInternet) {
              context.read<CourseWithSectionsBloc>().add(
                CourseWithSectionE(courseId: widget.courseId),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Internet mavjud emas!"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<CourseWithSectionsBloc, CourseWithSectionsState>(
            builder: (context, state) {
              if (state is CourseWithSectionLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CourseWithSectionSuccess) {
                final course = state.courseWithSectionsEntity.course;
                final sections = state.courseWithSectionsEntity.sections;
                final progress =
                    state.courseWithSectionsEntity.progressPercentage;

                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: progress / 100,
                              minHeight: 8,
                              backgroundColor: Colors.grey.shade300,
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(height: 4),
                            Text("${progress.toStringAsFixed(1)}% tugallangan"),
                          ],
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: sections.length,
                          itemBuilder: (context, sectionIndex) {
                            final section = sections[sectionIndex];
                            final lessons = section.lessons;
                            return ExpansionTile(
                              title: Text(
                                section.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              children:
                                  lessons.map((lesson) {
                                    final isCompleted = lesson.userProgress;
                                    return ListTile(
                                      dense: true,
                                      leading: Icon(
                                        isCompleted.isNotEmpty
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color:
                                            isCompleted.isNotEmpty
                                                ? Colors.green
                                                : Colors.grey,
                                        size: 20,
                                      ),
                                      title: Text(
                                        lesson.title,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        context.read<LessonDetailBloc>().add(
                                          LessonDetailE(lessonId: lesson.id),
                                        );
                                      },
                                    );
                                  }).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is CourseWithSectionError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final hasInternet = await checkInternetConnection();
          if (hasInternet) {
            context.read<CourseWithSectionsBloc>().add(
              CourseWithSectionE(courseId: widget.courseId),
            );
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child:
                BlocConsumer<CourseWithSectionsBloc, CourseWithSectionsState>(
                  listener: (context, state) {
                    if (state is CourseWithSectionSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("✅ Darsni yakunladingiz!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<LessonDetailBloc, LessonDetailState>(
                      builder: (context, state) {
                        if (state is LessonDetailLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is LessonDetailSuccess) {
                          final lesson = state.lessonDetailsEntity;
                          if (_controllers.length != lesson.tasks.length) {
                            _controllers = List.generate(
                              lesson.tasks.length,
                              (_) => TextEditingController(),
                            );
                          }
                          if (_isCorrectList.length != lesson.tasks.length) {
                            _isCorrectList = List.generate(
                              lesson.tasks.length,
                              (_) => false,
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (lesson.videoUrl.isNotEmpty)
                                SizedBox(
                                  height: 200,
                                  child: VimeoVideoPlayer(
                                    videoUrl: lesson.videoUrl,
                                  ),
                                ),
                              const SizedBox(height: 20),
                              Text(
                                lesson.title,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(),
                              Text(
                                "Darsga oid lug‘at:",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: lesson.dictionary.split(', ').length,
                                itemBuilder: (context, index) {
                                  final item =
                                  lesson.dictionary.split(', ')[index];
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
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              if (lesson.audioUrl.isNotEmpty)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.audioWebViewPage,
                                      arguments: lesson.audioUrl,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.headphones,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    "Lug'atlarni eshitib oson yodlang",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white,
                                    elevation: 4,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadowColor: Colors.deepPurpleAccent
                                        .withOpacity(0.4),
                                  ),
                                ),
                              const Divider(),
                              Text(
                                "Mashqlar",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ...lesson.tasks.asMap().entries.map((entry) {
                                final index = entry.key;
                                final task = entry.value;
                                return _buildTaskWidget(task, index);
                              }).toList(),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed:
                                    allAnsweredCorrectly
                                        ? () {
                                          context
                                              .read<CourseWithSectionsBloc>()
                                              .add(
                                                CompleteLessonSubmitted(
                                                  lessonId: lesson.id,
                                                  courseId: widget.courseId.id,
                                                ),
                                              );
                                        }
                                        : null,
                                child: const Text("Darsni yakunlash"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      allAnsweredCorrectly
                                          ? Colors.green
                                          : Colors.grey,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Builder(
                            builder: (context) {
                              return Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: Text("Darsni Tanlang"),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskWidget(TaskEntity task, int index) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isError = false;
        bool isAnswered = _isCorrectList[index];
        bool hasAttempted = _controllers[index].text.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.image.isNotEmpty) Image.network(task.image),
            const SizedBox(height: 15),
            Text(
              "Savol: ${task.text}",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controllers[index],
              readOnly: isAnswered,
              decoration: InputDecoration(
                labelText: "Javob (UZ)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText: isError ? "❌ Xato javob kiritdingiz!" : null,
              ),
            ),
            const SizedBox(height: 10),

            if (!isAnswered)
              ElevatedButton.icon(
                onPressed: () {
                  String userAnswer =
                  _controllers[index].text.trim().toLowerCase();
                  String correctAnswer = task.textUz.trim().toLowerCase();

                  if (userAnswer == correctAnswer) {
                    setState(() {
                      isError = false;
                      _isCorrectList[index] = true;
                    });

                    this.setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("✅ Javob to'g'ri!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    setState(() {
                      isError = true;
                      _isCorrectList[index] = false;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("❌ Xato javob kiritdingiz!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text("Tekshirish"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

}
