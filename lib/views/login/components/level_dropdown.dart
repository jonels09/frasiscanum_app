import 'package:flutter/material.dart';

class LevelDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const LevelDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items:
            ['Mpijerijery', 'Firosoana', 'Fanomezan-toky'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: "Dingana vita",
          hintStyle: TextStyle(fontSize: 14, color: Colors.brown),
        ),
        style: const TextStyle(color: Colors.brown),
      ),
    );
  }
}
