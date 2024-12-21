import 'package:flutter/material.dart';
import '../../../models/quiz_score.dart';
import 'package:intl/intl.dart';

class ScoreCard extends StatelessWidget {
  final QuizScore score;

  const ScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getColorForScore(score.percentage),
          child: Text(
            '${score.percentage.round()}%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          score.category == 'franciscain'
              ? 'Quiz Franciscain'
              : 'Quiz Catholique',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Score: ${score.score}/${score.totalQuestions}\n${DateFormat('dd/MM/yyyy HH:mm').format(score.date)}',
        ),
        isThreeLine: true,
      ),
    );
  }

  Color _getColorForScore(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    return Colors.red;
  }
}
