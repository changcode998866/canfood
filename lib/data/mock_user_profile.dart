import 'package:flutter/material.dart';

import '../models/food_order.dart';
import '../models/user_profile.dart';

const mockUserProfile = UserProfile(
  nickname: '小食光',
  phoneMasked: '138****6520',
  memberLevel: '食光会员 Lv.2',
  couponCount: 3,
  points: 860,
  favoriteCount: 12,
);

const profileOrderShortcuts = [
  ProfileOrderShortcut(
    label: '待支付',
    icon: Icons.payment_rounded,
    filter: OrderFilter.pendingPayment,
    badgeCount: 1,
  ),
  ProfileOrderShortcut(
    label: '待配送',
    icon: Icons.delivery_dining_rounded,
    filter: OrderFilter.inProgress,
    badgeCount: 1,
  ),
  ProfileOrderShortcut(
    label: '待评价',
    icon: Icons.rate_review_outlined,
    filter: OrderFilter.completed,
    badgeCount: 1,
  ),
  ProfileOrderShortcut(
    label: '退款/售后',
    icon: Icons.assignment_return_outlined,
    filter: OrderFilter.refund,
    badgeCount: 1,
  ),
];

class ProfileMenuItem {
  const ProfileMenuItem({
    required this.title,
    required this.icon,
    this.subtitle,
  });

  final String title;
  final IconData icon;
  final String? subtitle;
}

const profileServiceMenus = [
  ProfileMenuItem(
    title: '收货地址',
    icon: Icons.location_on_outlined,
    subtitle: '西溪银泰城',
  ),
  ProfileMenuItem(title: '我的收藏', icon: Icons.favorite_border_rounded),
  ProfileMenuItem(title: '红包卡券', icon: Icons.card_giftcard_outlined),
  ProfileMenuItem(title: '发票助手', icon: Icons.receipt_outlined),
];

const profileMoreMenus = [
  ProfileMenuItem(title: '帮助与客服', icon: Icons.headset_mic_outlined),
  ProfileMenuItem(title: '设置', icon: Icons.settings_outlined),
  ProfileMenuItem(title: '关于食光', icon: Icons.info_outline_rounded),
];
