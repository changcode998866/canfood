import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, required this.icon, required this.label});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.chipInactive,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: AppColors.textSecondary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
