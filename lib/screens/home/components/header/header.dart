import 'package:flutter/material.dart';
import 'user_avatar.dart';
import 'user_name.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String? gender;
  final VoidCallback onDrawerOpen;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.gender,
    required this.onDrawerOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          UserAvatar(
            gender: gender,
            onTap: onDrawerOpen,
          ),
          const SizedBox(width: 12),
          UserName(name: userName),
        ],
      ),
    );
  }
}
