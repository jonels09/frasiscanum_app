import 'package:flutter/material.dart';
import '../../../models/quiz_question.dart';
import 'answer_button.dart';

class QuestionCard extends StatelessWidget {
  final QuizQuestion question;
  final Function(int) onAnswerSelected;
  final int? selectedAnswer;
  final bool showResult;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    required this.selectedAnswer,
    required this.showResult,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                question.question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(
            question.options.length,
            (index) => AnswerButton(
              text: question.options[index],
              onPressed: () => onAnswerSelected(index),
              isCorrect: showResult ? index == question.correctAnswer : null,
              isSelected: selectedAnswer == index,
              showResult: showResult,
            ),
          ),
        ],
      ),
    );
  }
}
