/*import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String gender;
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
}*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/storage_service.dart';

class UserAvatar extends StatelessWidget {
  final String gender;
  final VoidCallback onTap;

  const UserAvatar({
    super.key,
    required this.gender,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircleAvatar(
            backgroundColor: Colors.white,
            child: CircularProgressIndicator(),
          );
        }

        final storageService = StorageService(snapshot.data!);
        final userImage = storageService.getUserImage() ??
            (gender == 'male'
                ? 'assets/images/boy.png'
                : 'assets/images/girl.png');

        return GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(
              userImage,
              width: 30,
              height: 30,
              //color: const Color(0xFF8B4513),
            ),
          ),
        );
      },
    );
  }
}
