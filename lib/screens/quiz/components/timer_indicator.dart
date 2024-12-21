import 'package:flutter/material.dart';

class TimerIndicator extends StatelessWidget {
  final int timeLeft;
  final int totalTime;

  const TimerIndicator({
    super.key,
    required this.timeLeft,
    this.totalTime = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: timeLeft / totalTime,
            backgroundColor: Colors.grey[300],
            color: _getColorForTime(timeLeft),
            strokeWidth: 8,
          ),
          Center(
            child: Text(
              timeLeft.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForTime(int time) {
    if (time > 20) return Colors.green;
    if (time > 10) return Colors.orange;
    return Colors.red;
  }
}
