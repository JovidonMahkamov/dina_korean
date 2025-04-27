import 'package:flutter/material.dart';

class OnlineLessonPage extends StatefulWidget {
  const OnlineLessonPage({super.key});

  @override
  State<OnlineLessonPage> createState() => _OnlineLessonPageState();
}

class _OnlineLessonPageState extends State<OnlineLessonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Online lessons')),
    );
  }
}
