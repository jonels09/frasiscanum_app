/*import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isValid;

  const SubmitButton({
    super.key,
    required this.onTap,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 522,
      right: 0,
      left: 0,
      child: Center(
        child: GestureDetector(
          onTap: isValid ? onTap : null,
          child: Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(45),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 10),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/storage_service.dart';

class SubmitButton extends StatelessWidget {
  final bool showShadow;
  final bool isValid;
  final String firstName;
  final String lastName;
  final String level;
  final String gender;

  const SubmitButton({
    super.key,
    required this.showShadow,
    required this.isValid,
    required this.firstName,
    required this.lastName,
    required this.level,
    required this.gender,
  });

  Future<void> _handleSubmit(BuildContext context) async {
    if (!isValid) return;

    final prefs = await SharedPreferences.getInstance();
    final storageService = StorageService(prefs);

    await storageService.saveUserData(
      firstName: firstName,
      lastName: lastName,
      level: level,
      gender: gender,
    );

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 535,
      right: 0,
      left: 0,
      child: Center(
        child: GestureDetector(
          onTap: isValid ? () => _handleSubmit(context) : null,
          child: Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: showShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        spreadRadius: 1.5,
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      )
                    ]
                  : null,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isValid ? Colors.brown : Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
/*
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool showShadow;
  final bool isValid;
  final VoidCallback onTap;

  const SubmitButton({
    super.key,
    required this.showShadow,
    required this.isValid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 535,
      right: 0,
      left: 0,
      child: Center(
        child: GestureDetector(
          onTap: isValid ? onTap : null,
          child: Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isValid ? Colors.brown : Colors.grey,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool showShadow;
  final bool isValid;
  final VoidCallback onTap;

  const SubmitButton({
    super.key,
    required this.showShadow,
    required this.isValid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Center(
        child: GestureDetector(
          onTap: isValid ? onTap : null,
          child: Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(15),
            /*decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ],
            ),*/
            child: Container(
              decoration: BoxDecoration(
                color: isValid ? Colors.brown : Colors.grey,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
