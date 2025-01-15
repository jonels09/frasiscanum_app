import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: SizedBox(
        height: 300,
        child: Image.asset(
          'assets/images/about-us.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
