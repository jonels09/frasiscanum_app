/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/storage_service.dart';
import 'user_avatar.dart';
import 'user_name.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final storageService = StorageService(snapshot.data!);

        return FutureBuilder<Map<String, String?>>(
          future: storageService.getUserData(),
          builder: (context, userSnapshot) {
            if (!userSnapshot.hasData) {
              return const SizedBox.shrink();
            }

            final userData = userSnapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  UserAvatar(gender: userData['gender'] ?? 'male'),
                  const SizedBox(width: 12),
                  UserName(name: userData['lastName'] ?? ''),
                ],
              ),
            );
          },
        );
      },
    );
  }
}*/

import 'package:flutter/material.dart';
import 'user_avatar.dart';
import 'user_name.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String gender;
  final VoidCallback onMenuPressed;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.gender,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          UserAvatar(
            gender: gender,
            onTap: onMenuPressed,
          ),
          const SizedBox(width: 12),
          UserName(name: userName),
        ],
      ),
    );
  }
}
