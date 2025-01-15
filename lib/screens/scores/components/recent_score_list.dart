import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../../models/quiz_score.dart';

class RecentScoreList extends StatelessWidget {
  final List<QuizScore> scores;

  const RecentScoreList({
    super.key,
    required this.scores,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: scores.length,
      itemBuilder: (context, index) {
        final score = scores[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getScoreColor(score.percentage),
              child: Text(
                '${score.score}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            title: Text(
              score.category == 'franciscain'
                  ? 'Quiz Franciscain'
                  : 'Quiz Catholique',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy HH:mm').format(score.date),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        );
      },
    );
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    return Colors.red;
  }
}
