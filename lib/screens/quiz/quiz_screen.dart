import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/quiz_question.dart';
import '../../services/quiz_service.dart';
import '../../services/score_service.dart';
import '../../models/quiz_score.dart';
import 'components/question_card.dart';
import 'components/timer_indicator.dart';
import 'quiz_timer.dart';

class QuizScreen extends StatefulWidget {
  final String category;

  const QuizScreen({
    super.key,
    required this.category,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

// ... (code précédent inchangé jusqu'à showDialog)
class _QuizScreenState extends State<QuizScreen> {
  final QuizService _quizService = QuizService();
  late ScoreService _scoreService;
  late List<QuizQuestion> _questions;
  late QuizTimer _timer;

  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 30;
  int? _selectedAnswer;
  bool _showResult = false;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initQuiz();
  }

  Future<void> _initQuiz() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _scoreService = ScoreService(prefs);

      final questions = await _quizService.loadQuestions(widget.category);
      setState(() {
        _questions = questions;
        _isLoading = false;
      });

      _startTimer();
    } catch (e) {
      setState(() {
        _error = 'Erreur lors du chargement des questions';
        _isLoading = false;
      });
    }
  }

  void _startTimer() {
    _timer = QuizTimer(
      duration: 30,
      onTick: (timeLeft) {
        setState(() => _timeLeft = timeLeft);
      },
      onFinished: () {
        _showGameOverDialog(isTimeout: true);
      },
    );
    _timer.start();
  }

  Future<void> _handleAnswer(int answerIndex) async {
    if (_selectedAnswer != null) return;

    setState(() {
      _selectedAnswer = answerIndex;
      _showResult = true;
    });

    _timer.stop();

    if (answerIndex == _questions[_currentQuestionIndex].correctAnswer) {
      setState(() => _score++);
      await Future.delayed(const Duration(seconds: 1));

      if (_currentQuestionIndex < _questions.length - 1) {
        _nextQuestion();
      } else {
        _showGameOverDialog();
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        _showGameOverDialog(isWrongAnswer: true);
      }
    }
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _showResult = false;
      _timeLeft = 30;
    });
    _timer.start();
  }

  Future<void> _saveScore() async {
    try {
      final score = QuizScore(
        category: widget.category,
        score: _score,
        totalQuestions: _questions.length,
        date: DateTime.now(),
      );
      await _scoreService.saveScore(score);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la sauvegarde du score'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showGameOverDialog(
      {bool isTimeout = false, bool isWrongAnswer = false}) async {
    await _saveScore();

    if (!mounted) return;

    String message;
    if (isTimeout) {
      message = 'Temps écoulé !';
    } else if (isWrongAnswer) {
      message = 'Mauvaise réponse !';
    } else {
      message = 'Quiz terminé !';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(message),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Score final: $_score/${_questions.length}'),
              const SizedBox(height: 16),
              Text(
                'Pourcentage: ${(_score / _questions.length * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialog
                Navigator.of(context).pop(); // Retourne à l'écran précédent
              },
              child: const Text('Retour au menu'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!),
              ElevatedButton(
                onPressed: _initQuiz,
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category == 'franciscain'
              ? 'Quiz Franciscain'
              : 'Quiz Catholique'),
          backgroundColor: const Color(0xFF8B4513),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: TimerIndicator(
                  timeLeft: _timeLeft,
                ),
              ),
            ),
            Expanded(
              child: QuestionCard(
                question: _questions[_currentQuestionIndex],
                onAnswerSelected: _handleAnswer,
                selectedAnswer: _selectedAnswer,
                showResult: _showResult,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
