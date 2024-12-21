import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/quiz_question.dart';
import '../../services/quiz_service.dart';
import '../../models/quiz_score.dart';
import '../../services/score_service.dart';
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

class _QuizScreenState extends State<QuizScreen> {
  final QuizService _quizService = QuizService();
  late ScoreService _scoreService;
  late QuizTimer _quizTimer;
  List<QuizQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 30;
  bool _isLoading = true;
  bool _showResult = false;
  int? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _initQuizTimer();
    _initServices();
  }

  void _initQuizTimer() {
    _quizTimer = QuizTimer(
      duration: 30,
      onTick: (timeLeft) {
        if (mounted) {
          setState(() => _timeLeft = timeLeft);
        }
      },
      onFinished: () => _handleAnswer(-1),
    );
  }

  Future<void> _initServices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _scoreService = ScoreService(prefs);
      await _loadQuestions();
      if (mounted) {
        _quizTimer.start();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Erreur lors de l\'initialisation'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Réessayer',
              textColor: Colors.white,
              onPressed: _initServices,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _quizTimer.dispose();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await _quizService.loadQuestions(widget.category);
      if (mounted) {
        setState(() {
          _questions = questions;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Erreur lors du chargement des questions'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Réessayer',
              textColor: Colors.white,
              onPressed: _loadQuestions,
            ),
          ),
        );
      }
    }
  }

  void _handleAnswer(int selectedAnswer) {
    if (_showResult) return;
    _quizTimer.stop();

    setState(() {
      _showResult = true;
      _selectedAnswer = selectedAnswer;
    });

    if (selectedAnswer == _questions[_currentQuestionIndex].correctAnswer) {
      setState(() {
        _score++;
      });
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _timeLeft = 30;
          _showResult = false;
          _selectedAnswer = null;
        });
        _quizTimer.start();
      } else {
        _saveScore();
        _showResults();
      }
    });
  }

  Future<void> _saveScore() async {
    final score = QuizScore(
      category: widget.category,
      score: _score,
      totalQuestions: _questions.length,
      date: DateTime.now(),
    );
    await _scoreService.saveScore(score);
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz terminé !'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: $_score/${_questions.length}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Pourcentage: ${(_score / _questions.length * 100).round()}%',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Return to home
            },
            child: const Text('Retour à l\'accueil'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.category == 'franciscain'
              ? 'Quiz Franciscain'
              : 'Quiz Catholique'),
          backgroundColor: const Color(0xFF8B4513),
        ),
        body: const Center(
          child: Text('Aucune question disponible'),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.category == 'franciscain'
            ? 'Quiz Franciscain'
            : 'Quiz Catholique'),
        backgroundColor: const Color(0xFF8B4513),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: TimerIndicator(timeLeft: _timeLeft),
              ),
            ),
            Expanded(
              child: QuestionCard(
                question: currentQuestion,
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
