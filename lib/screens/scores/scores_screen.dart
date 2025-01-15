import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/quiz_score.dart';
import '../../services/score_service.dart';
import 'components/category_dropdown.dart';
import 'components/best_score_card.dart';
import 'components/recent_score_list.dart';

class ScoresScreen extends StatefulWidget {
  const ScoresScreen({super.key});

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  late ScoreService _scoreService;
  List<QuizScore> _scores = [];
  String _selectedCategory = 'franciscain';
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initScoreService();
  }

  Future<void> _initScoreService() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _scoreService = ScoreService(prefs);
      await _loadScores();
    } catch (e) {
      setState(() {
        _error = 'Erreur lors de l\'initialisation';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadScores() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final scores = await _scoreService.getScores();
      if (mounted) {
        setState(() {
          _scores = scores..sort((a, b) => b.date.compareTo(a.date));
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Erreur lors du chargement des scores';
          _isLoading = false;
        });
      }
    }
  }

  List<QuizScore> get filteredScores {
    return _scores.where((s) => s.category == _selectedCategory).toList();
  }

  QuizScore? get bestScore {
    final scores = filteredScores;
    if (scores.isEmpty) return null;
    return scores.reduce((a, b) => a.percentage > b.percentage ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Mes Scores'),
        backgroundColor: const Color(0xFF8B4513),
      ),
      body: RefreshIndicator(
        onRefresh: _loadScores,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryDropdown(
                selectedCategory: _selectedCategory,
                onChanged: (category) {
                  if (category != null) {
                    setState(() => _selectedCategory = category);
                  }
                },
              ),
              const SizedBox(height: 24),
              if (_error != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _error!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadScores,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B4513),
                          ),
                          child: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                if (bestScore != null) ...[
                  BestScoreCard(score: bestScore!),
                  const SizedBox(height: 24),
                ],
                const Text(
                  'Historique Récent',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (filteredScores.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.emoji_events_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun score disponible',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  RecentScoreList(
                    scores: filteredScores.take(10).toList(),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
