import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(color: Colors.brown),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: const EdgeInsets.all(10),
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14, color: Colors.brown),
        ),
      ),
    );
  }
}
