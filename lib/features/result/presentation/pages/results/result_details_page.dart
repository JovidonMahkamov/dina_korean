import 'package:flutter/material.dart';
import 'package:dina_korean_real/features/result/domain/entities/result.dart';

class ResultDetailPage extends StatelessWidget {
  final Result result;

  const ResultDetailPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(result.type)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                result.img,
                width: double.infinity,
                // height: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

