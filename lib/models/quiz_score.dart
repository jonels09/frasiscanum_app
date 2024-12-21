class QuizScore {
  final String category;
  final int score;
  final int totalQuestions;
  final DateTime date;

  QuizScore({
    required this.category,
    required this.score,
    required this.totalQuestions,
    required this.date,
  });

  double get percentage => (score / totalQuestions) * 100;

  factory QuizScore.fromJson(Map<String, dynamic> json) {
    return QuizScore(
      category: json['category'],
      score: json['score'],
      totalQuestions: json['totalQuestions'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'score': score,
      'totalQuestions': totalQuestions,
      'date': date.toIso8601String(),
    };
  }
}
