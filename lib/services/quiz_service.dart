import 'dart:convert';
import '../models/quiz_question.dart';
import '../utils/file_utils.dart';
import '../utils/list_utils.dart';

class QuizService {
  Future<List<QuizQuestion>> loadQuestions(String category) async {
    try {
      final String jsonFile = _getJsonFilePath(category);
      final String jsonString = await FileUtils.loadAsset(jsonFile);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      if (!jsonData.containsKey('questions')) {
        throw FormatException('Invalid JSON format: missing questions key');
      }

      final questions = (jsonData['questions'] as List)
          .map((q) => QuizQuestion.fromJson(q))
          .toList();

      // Shuffle questions
      ListUtils.shuffle(questions);

      // Shuffle options for each question
      for (var question in questions) {
        question.shuffleOptions();
      }

      return questions;
    } catch (e) {
      throw QuizServiceException('Failed to load questions: ${e.toString()}');
    }
  }

  String _getJsonFilePath(String category) {
    switch (category.toLowerCase()) {
      case 'franciscain':
        return 'assets/data/franciscan_questions.json';
      case 'catholique':
        return 'assets/data/catholic_questions.json';
      default:
        throw QuizServiceException('Invalid category: $category');
    }
  }
}

class QuizServiceException implements Exception {
  final String message;
  QuizServiceException(this.message);

  @override
  String toString() => message;
}
