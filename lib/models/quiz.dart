class Question {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String? imageUrl;
  final String category;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.imageUrl,
    required this.category,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      imageUrl: json['imageUrl'],
      category: json['category'],
    );
  }
}

class QuizCategory {
  final String id;
  final String name;
  final String description;
  final String iconPath;

  QuizCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
  });
}
