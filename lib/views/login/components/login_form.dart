import 'package:flutter/material.dart';
import 'package:franciscanum_quiz/views/widgets/gender_selector.dart';
import '../../../viewmodels/login_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import 'level_dropdown.dart';

class LoginForm extends StatelessWidget {
  final LoginViewModel viewModel;

  const LoginForm({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 280,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width - 40,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              label: 'Anarana',
              onChanged: viewModel.setFirstName,
            ),
            CustomTextField(
              label: 'Fanampiny',
              onChanged: viewModel.setLastName,
            ),
            LevelDropdown(
              value: viewModel.level,
              onChanged: (value) {
                if (value != null) viewModel.setLevel(value);
              },
            ),
            GenderSelector(
              isMale: viewModel.isMale,
              onGenderChanged: viewModel.setGender,
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
