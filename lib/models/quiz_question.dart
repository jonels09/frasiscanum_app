/*import '../utils/list_utils.dart';

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  int correctAnswer;
  final String category;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.category,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    final originalOptions = List<String>.from(json['options']);
    final originalCorrectAnswer = json['correctAnswer'];

    return QuizQuestion(
      id: json['id'],
      question: json['question'],
      options: originalOptions,
      correctAnswer: originalCorrectAnswer,
      category: json['category'],
    );
  }

  void shuffleOptions() {
    final correctOption = options[correctAnswer];
    ListUtils.shuffle(options);
    correctAnswer = options.indexOf(correctOption);
  }
}
*/
import '../utils/list_utils.dart';

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  int correctAnswer;
  final String category;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.category,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    final List<dynamic> optionsList = json['options'] as List<dynamic>;
    final List<String> options = optionsList.map((e) => e.toString()).toList();

    return QuizQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
      options: options,
      correctAnswer: json['correctAnswer'] as int,
      category: json['category'] as String,
    );
  }

  void shuffleOptions() {
    final correctOption = options[correctAnswer];
    ListUtils.shuffle(options);
    correctAnswer = options.indexOf(correctOption);
  }
}
