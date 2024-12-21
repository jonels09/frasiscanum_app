import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/quiz_score.dart';

class ScoreService {
  static const String _scoresKey = 'quiz_scores';
  final SharedPreferences _prefs;

  ScoreService(this._prefs);

  Future<void> saveScore(QuizScore score) async {
    final scores = await getScores();
    scores.add(score);
    await _prefs.setString(
        _scoresKey,
        jsonEncode(
          scores.map((s) => s.toJson()).toList(),
        ));
  }

  Future<List<QuizScore>> getScores() async {
    final String? scoresJson = _prefs.getString(_scoresKey);
    if (scoresJson == null) return [];

    final List<dynamic> scoresList = jsonDecode(scoresJson);
    return scoresList.map((json) => QuizScore.fromJson(json)).toList();
  }

  Future<Map<String, double>> getAverageScoresByCategory() async {
    final scores = await getScores();
    final Map<String, List<double>> categoryScores = {};

    for (var score in scores) {
      categoryScores.putIfAbsent(score.category, () => []);
      categoryScores[score.category]!.add(score.percentage);
    }

    return Map.fromEntries(
      categoryScores.entries.map(
        (entry) => MapEntry(
          entry.key,
          entry.value.reduce((a, b) => a + b) / entry.value.length,
        ),
      ),
    );
  }
}
