import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/quiz.dart';
import '../scores/scores_screen.dart';
import 'components/app_drawer.dart';
import 'components/category_list_item.dart';
import 'components/header/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToQuiz(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      '/quiz',
      arguments: {'category': category.toLowerCase()},
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final categories = [
      QuizCategory(
        id: 'franciscain',
        name: 'Franciscain',
        description: 'Formation franciscaine',
        iconPath: '',
      ),
      QuizCategory(
        id: 'catholique',
        name: 'Catholique',
        description: 'Ressources catholiques',
        iconPath: '',
      ),
      QuizCategory(
        id: 'score',
        name: 'Score',
        description: 'Vos résultats',
        iconPath: '',
      ),
      QuizCategory(
        id: 'prieres',
        name: 'Prières',
        description: 'Prières quotidiennes',
        iconPath: '',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF8B4513),
      drawer: AppDrawer(
        user: user,
        onThemeChanged: () {
          // TODO: Implement theme change
        },
        onLanguageChanged: () {
          // TODO: Implement language change
        },
      ),
      body: Builder(
        builder: (context) => SafeArea(
          child: Column(
            children: [
              HomeHeader(
                userName: user?.firstName ?? '',
                gender: user?.gender,
                onDrawerOpen: () => Scaffold.of(context).openDrawer(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Fiadanana sy Hafaliana',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 24),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryListItem(
                        category: categories[index],
                        onTap: () {
                          if (categories[index].id == 'franciscain' ||
                              categories[index].id == 'catholique') {
                            _navigateToQuiz(context, categories[index].id);
                          } else if (categories[index].id == 'score') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScoresScreen()),
                            );
                          } else {
                            print("clique");
                          }
                          // Handle other categories (score, prieres) here
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
