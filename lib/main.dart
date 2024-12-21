import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/auth_provider.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/quiz/quiz_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool skipOnboarding = prefs.getBool('skip_onboarding') ?? false;
  final bool onboardingCompleted =
      prefs.getBool('onboarding_completed') ?? false;
  final bool isLoggedIn = prefs.getString('user') != null;

  runApp(MyApp(
    prefs: prefs,
    skipOnboarding: skipOnboarding,
    onboardingCompleted: onboardingCompleted,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final bool skipOnboarding;
  final bool onboardingCompleted;
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.prefs,
    required this.skipOnboarding,
    required this.onboardingCompleted,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(prefs)),
      ],
      child: MaterialApp(
        title: 'Franciscanum Quiz',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _getInitialScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/quiz') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => QuizScreen(
                category: args['category'] as String,
              ),
            );
          }
          return null;
        },
      ),
    );
  }

  Widget _getInitialScreen() {
    if (isLoggedIn) {
      return const HomeScreen();
    }
    if (!onboardingCompleted || !skipOnboarding) {
      return const OnboardingScreen();
    }
    return const LoginScreen();
  }
}
