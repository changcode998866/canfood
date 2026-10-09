import 'package:flutter/material.dart';

import 'food_order.dart';

class UserProfile {
  const UserProfile({
    required this.nickname,
    required this.phoneMasked,
    required this.memberLevel,
    required this.couponCount,
    required this.points,
    required this.favoriteCount,
  });

  final String nickname;
  final String phoneMasked;
  final String memberLevel;
  final int couponCount;
  final int points;
  final int favoriteCount;
}

class ProfileOrderShortcut {
  const ProfileOrderShortcut({
    required this.label,
    required this.icon,
    required this.filter,
    this.badgeCount = 0,
  });

  final String label;
  final IconData icon;
  final OrderFilter filter;
  final int badgeCount;
}
