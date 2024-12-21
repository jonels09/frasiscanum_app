import 'package:flutter/material.dart';
import '../login_screen.dart';
import 'onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _skipOnboarding = false;

  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      title: 'Formation Franciscaine',
      description:
          'Découvrez les modules de formation franciscains pour approfondir votre spiritualité.',
      imagePath: 'assets/images/franciscan.png',
      color: const Color(0xFF8B4513),
    ),
    OnboardingPageData(
      title: 'Ressources Catholiques',
      description:
          'Accédez à une riche collection de ressources catholiques pour nourrir votre foi.',
      imagePath: 'assets/images/catholic.png',
      color: const Color(0xFF654321),
    ),
    OnboardingPageData(
      title: 'Quiz Interactif',
      description:
          'Testez vos connaissances à travers des quiz interactifs et enrichissants.',
      imagePath: 'assets/images/quiz.png',
      color: const Color(0xFF8B4513),
    ),
  ];

  void _onNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    if (_skipOnboarding) {
      await prefs.setBool('skip_onboarding', true);
    }
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return OnboardingPage(data: _pages[index]);
            },
          ),
          Positioned(
            bottom: 48.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                if (_currentPage == _pages.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _skipOnboarding,
                          onChanged: (value) {
                            setState(() {
                              _skipOnboarding = value ?? false;
                            });
                          },
                          fillColor: MaterialStateProperty.all(Colors.white),
                          checkColor: Colors.brown,
                        ),
                        const Text(
                          'Ne plus afficher au prochain démarrage',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: _onNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.brown,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? 'Commencer'
                          : 'Suivant',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
