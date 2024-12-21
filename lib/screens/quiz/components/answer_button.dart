import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool? isCorrect;
  final bool isSelected;
  final bool showResult;

  const AnswerButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isCorrect,
    required this.isSelected,
    required this.showResult,
  });

  Color _getButtonColor() {
    if (!showResult) return Colors.white;
    if (isSelected && isCorrect == true) return Colors.green.shade100;
    if (isSelected && isCorrect == false) return Colors.red.shade100;
    if (!isSelected && isCorrect == true) return Colors.green.shade100;
    return Colors.white;
  }

  Color _getBorderColor() {
    if (!showResult) return Colors.grey.shade300;
    if (isSelected && isCorrect == true) return Colors.green;
    if (isSelected && isCorrect == false) return Colors.red;
    if (!isSelected && isCorrect == true) return Colors.green;
    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ElevatedButton(
        onPressed: showResult ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getButtonColor(),
          foregroundColor: const Color(0xFF8B4513),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: _getBorderColor(),
              width: 2,
            ),
          ),
          elevation: 2,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
