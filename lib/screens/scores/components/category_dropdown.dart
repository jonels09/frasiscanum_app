import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final String selectedCategory;
  final Function(String?) onChanged;

  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: const [
            DropdownMenuItem(
              value: 'franciscain',
              child: Text('Quiz Franciscain'),
            ),
            DropdownMenuItem(
              value: 'catholique',
              child: Text('Quiz Catholique'),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
