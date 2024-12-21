import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? gender;
  final VoidCallback onTap;

  const UserAvatar({
    super.key,
    required this.gender,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          gender == 'male' ? Icons.male : Icons.female,
          color: const Color(0xFF8B4513),
        ),
      ),
    );
  }
}
