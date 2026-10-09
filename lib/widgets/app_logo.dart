import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// In-app brand mark; launcher icons use [assets/icon/app_icon.png].
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 36, this.borderRadius = 10});

  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        'assets/icon/app_icon.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Text(
            '食',
            style: TextStyle(
              color: Colors.white,
              fontSize: size * 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
