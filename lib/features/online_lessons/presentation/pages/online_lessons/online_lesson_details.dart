import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dina_korean_real/core/route/route_names.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/course_with_sections/course_with_sections_bloc.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/course_with_sections/course_with_sections_state.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/lesson_detail/lesson_detail_bloc.dart';
import 'package:dina_korean_real/features/online_lessons/presentation/bloc/lesson_detail/lesson_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/untils/logger.dart';
import '../../../domain/entities/course_entity.dart';
import '../../../domain/entities/lesson_details_entity.dart';
import '../../../domain/entities/lesson_entity.dart';
import '../../../domain/entities/section_entity.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/repository/course_repo.dart';
import '../../bloc/course_event.dart';
import '../../bloc/user_cheek/user_cheek_bloc.dart';
import '../../bloc/user_cheek/user_cheek_state.dart';
import '../../widget/vimeo_wg.dart';

class OnlineLessonDetails extends StatefulWidget {
  final CourseEntity courseId;

  const OnlineLessonDetails({super.key, required this.courseId});

  @override
  State<OnlineLessonDetails> createState() => _OnlineLessonDetailsState();
}

class _OnlineLessonDetailsState extends State<OnlineLessonDetails> {
  Map<int, TextEditingController> _controllers = {};
  Set<int> _answeredTaskIds = {};

  @override
  void initState() {
    super.initState();
    context.read<CourseWithSectionsBloc>().add(
      CourseWithSectionE(courseId: widget.courseId),
    );
  }

  Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _markLessonAsCompleted(int lessonId) {
    context.read<LessonDetailBloc>().add(LessonDetailE(lessonId: lessonId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Dars muvaffaqiyatli yakunlandi!"),
        backgroundColor: Colors.green,
      ),
    );
    context.read<CourseWithSectionsBloc>().add(
      CourseWithSectionE(courseId: widget.courseId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckAnswerBloc(courseRepo: context.read<CourseRepo>()),
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: _buildDrawer(),
        body: BlocBuilder<LessonDetailBloc, LessonDetailState>(
          builder: (context, state) {
            if (state is LessonDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LessonDetailSuccess) {
              final lesson = state.lessonDetailsEntity;
              return RefreshIndicator(
                onRefresh: () async {
                  final hasInternet = await checkInternetConnection();
                  if (hasInternet) {
                    context.read<CourseWithSectionsBloc>().add(
                      CourseWithSectionE(courseId: widget.courseId),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Internet mavjud emas!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (lesson.videoUrl.isNotEmpty)
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: VimeoVideoPlayer(videoUrl: lesson.videoUrl),
                      ),
                    const SizedBox(height: 20),
                    Text(
                      lesson.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const Text(
                      "Darsga oid lug‘at:",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    ...lesson.dictionary.split(', ').map((item) {
                      final parts = item.split(' - ');
                      final kr = parts[0];
                      final uz = parts.length > 1 ? parts[1] : '';
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.verified_outlined,
                            color: Colors.blue),
                        title: Text("$kr - $uz"),
                      );
                    }).toList(),
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
                        icon: const Icon(Icons.headphones),
                        label: const Text("Lug'atlarni eshitish"),
                      ),
                    const Divider(),
                    const Text(
                      "Mashqlar",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    ...lesson.tasks
                        .map((task) => _buildTaskBlocWidget(task))
                        .toList(),
                  ],
                ),
              );
            } else if (state is LessonDetailError) {
              return Center(child: Text("Xatolik: ${state.message}"));
            } else {
              return const Center(child: Text("Darsni tanlang"));
            }
          },
        ),
      ),
    );
  }



  Widget _buildTaskBlocWidget(TaskEntity task) {
    _controllers.putIfAbsent(task.id, () => TextEditingController());

    return BlocConsumer<CheckAnswerBloc, CheckAnswerState>(
      listener: (context, state) {
        if (state is CheckAnswerCorrect) {
          setState(() {
            _answeredTaskIds.add(task.id);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("To‘g‘ri javob!"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is CheckAnswerIncorrect) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Noto‘g‘ri javob. Qayta urinib ko‘ring."),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is CheckAnswerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Xatolik yuz berdi."),
              backgroundColor: Colors.orange,
            ),
          );
        }
      },
      builder: (context, state) {
        final isAnswered = _answeredTaskIds.contains(task.id);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.image.isNotEmpty) Image.network(task.image),
            const SizedBox(height: 15),
            Text("Savol: ${task.text}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            TextField(
              controller: _controllers[task.id],
              enabled: !isAnswered,
              decoration: InputDecoration(
                hintText: "Javob (UZ/KR)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            if (!isAnswered)
              ElevatedButton.icon(
                onPressed: () {
                  final answer =
                  _controllers[task.id]!.text.trim().toLowerCase();
                  if (answer.isNotEmpty) {
                    context.read<CheckAnswerBloc>().add(
                      CheckAnswerEvent(
                        courseId: widget.courseId.id,
                        lessonId: task.lessonId,
                        answer: answer,
                      ),
                    );
                  }
                },
                icon: Icon(Icons.check),
                label: Text("Tekshirish"),
              ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: BlocBuilder<CourseWithSectionsBloc, CourseWithSectionsState>(
        builder: (context, state) {
          if (state is CourseWithSectionLoading) {
            return Center(child: CircularProgressIndicator());
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
                        Text(course.title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
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
                        return ExpansionTile(
                          title: Text(section.title),
                          children: section.lessons.map((lesson) {
                            final isCompleted =
                                lesson.userProgress.isNotEmpty;
                            return ListTile(
                              dense: true,
                              leading: Icon(
                                isCompleted
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: isCompleted ? Colors.green : Colors.grey,
                                size: 20,
                              ),
                              title: Text(lesson.title),
                              onTap: () {
                                Navigator.pop(context);
                                context.read<LessonDetailBloc>().add(
                                    LessonDetailE(lessonId: lesson.id));
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
    );
  }
}

