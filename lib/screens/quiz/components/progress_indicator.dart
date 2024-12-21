import 'package:flutter/material.dart';

class QuizProgressIndicator extends StatelessWidget {
  final int current;
  final int total;

  const QuizProgressIndicator({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Question $current/$total',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: current / total,
            backgroundColor: Colors.grey[300],
            color: const Color(0xFF8B4513),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
