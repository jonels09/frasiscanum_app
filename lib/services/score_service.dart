import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_score.dart';

class ScoreService {
  static const String _scoresKey = 'quiz_scores';
  final SharedPreferences _prefs;

  ScoreService(this._prefs);

  Future<void> saveScore(QuizScore score) async {
    try {
      final scores = await getScores();
      scores.add(score);

      final List<Map<String, dynamic>> jsonList =
          scores.map((s) => s.toJson()).toList();

      await _prefs.setString(_scoresKey, jsonEncode(jsonList));
    } catch (e) {
      // ignore: avoid_print
      print('Error saving score: $e');
      rethrow;
    }
  }

  Future<List<QuizScore>> getScores() async {
    try {
      final dynamic storedValue = _prefs.get(_scoresKey);

      if (storedValue == null) {
        return [];
      }

      if (storedValue is! String) {
        // Clear invalid data
        await _prefs.remove(_scoresKey);
        return [];
      }

      final List<dynamic> scoresList = jsonDecode(storedValue);
      return scoresList
          .map((json) => QuizScore.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } catch (e) {
      // ignore: avoid_print
      print('Error getting scores: $e');
      // Clear potentially corrupted data
      await _prefs.remove(_scoresKey);
      return [];
    }
  }

  Future<void> clearScores() async {
    await _prefs.remove(_scoresKey);
  }
}
