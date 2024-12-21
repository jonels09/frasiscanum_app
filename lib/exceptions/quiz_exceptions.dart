class QuizServiceException implements Exception {
  final String message;
  QuizServiceException(this.message);

  @override
  String toString() => message;
}
