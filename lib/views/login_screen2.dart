import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../viewmodels/login_viewmodel.dart';
import 'login/components/login_form.dart';
import 'login/components/login_header.dart';
import 'login/components/submit_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const LoginScreenContent(),
    );
  }
}

class LoginScreenContent extends StatelessWidget {
  const LoginScreenContent({super.key});

  Future<void> _handleSubmit(
      BuildContext context, LoginViewModel viewModel) async {
    if (viewModel.isValid) {
      try {
        final user = viewModel.buildUser();
        await Provider.of<AuthProvider>(context, listen: false).login(user);

        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erreur lors de la sauvegarde des données'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, _) {
          return Stack(
            children: [
              const LoginHeader(),
              LoginForm(viewModel: viewModel),
              SubmitButton(
                showShadow: true,
                isValid: viewModel.isValid,
                onTap: () => _handleSubmit(context, viewModel),
              ),
            ],
          );
        },
      ),
    );
  }
}
