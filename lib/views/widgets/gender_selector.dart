import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final bool isMale;
  final Function(bool) onGenderChanged;

  const GenderSelector({
    super.key,
    required this.isMale,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          _buildGenderOption(
            true,
            'Lehilahy',
            'assets/images/boy.png',
          ),
          const SizedBox(width: 30),
          _buildGenderOption(
            false,
            'Vehivavy',
            'assets/images/girl.png',
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(bool male, String label, String imagePath) {
    final isSelected = male == isMale;
    return GestureDetector(
      onTap: () => onGenderChanged(male),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.brown : Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias, // Ajout du clip
            child: Center(
              child: Image.asset(
                imagePath,
                width: 26, // Réduction de la taille
                height: 26, // Réduction de la taille
                fit: BoxFit.contain, // Assure que l'image s'adapte
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.brown : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
