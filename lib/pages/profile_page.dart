import 'package:flutter/material.dart';

import '../data/mock_user_profile.dart';
import '../models/food_order.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';

typedef ProfileNavigate = void Function(int tabIndex, {OrderFilter orderFilter});

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.onNavigate});

  final ProfileNavigate onNavigate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const _ProfileHeader(user: mockUserProfile),
        const SizedBox(height: 16),
        _ProfileStatsRow(
          user: mockUserProfile,
          onTapCoupons: () => _toast(context, '打开红包卡券'),
          onTapPoints: () => _toast(context, '积分商城即将上线'),
          onTapFavorites: () => _toast(context, '查看我的收藏'),
        ),
        const SizedBox(height: 16),
        _MemberCard(onTap: () => _toast(context, '查看会员权益')),
        const SizedBox(height: 16),
        _OrderShortcutPanel(
          onOpenAll: () => onNavigate(2),
          onOpenFilter: (filter) => onNavigate(2, orderFilter: filter),
        ),
        const SizedBox(height: 16),
        _MenuSection(
          title: '我的服务',
          items: profileServiceMenus,
          onTap: (item) => _toast(context, '打开${item.title}'),
        ),
        const SizedBox(height: 12),
        _MenuSection(
          title: '更多',
          items: profileMoreMenus,
          onTap: (item) => _toast(context, '打开${item.title}'),
        ),
      ],
    );
  }

  void _toast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_rounded,
            color: AppColors.primary,
            size: 36,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.nickname,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user.phoneMasked,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  user.memberLevel,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.qr_code_rounded, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _ProfileStatsRow extends StatelessWidget {
  const _ProfileStatsRow({
    required this.user,
    required this.onTapCoupons,
    required this.onTapPoints,
    required this.onTapFavorites,
  });

  final UserProfile user;
  final VoidCallback onTapCoupons;
  final VoidCallback onTapPoints;
  final VoidCallback onTapFavorites;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: _StatItem(
                value: '${user.couponCount}',
                label: '红包卡券',
                onTap: onTapCoupons,
              ),
            ),
            Container(width: 1, height: 28, color: AppColors.border),
            Expanded(
              child: _StatItem(
                value: '${user.points}',
                label: '积分',
                onTap: onTapPoints,
              ),
            ),
            Container(width: 1, height: 28, color: AppColors.border),
            Expanded(
              child: _StatItem(
                value: '${user.favoriteCount}',
                label: '收藏',
                onTap: onTapFavorites,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.onTap,
  });

  final String value;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF3D3D3D), Color(0xFF2A2A2A)],
          ),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '食光会员',
                    style: TextStyle(
                      color: Color(0xFFFFE8B8),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '每月 3 次免配送费 · 会员专享价',
                    style: TextStyle(color: Color(0xFFD4C4A8), fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE8B8),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                '查看权益',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3D3D3D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderShortcutPanel extends StatelessWidget {
  const _OrderShortcutPanel({
    required this.onOpenAll,
    required this.onOpenFilter,
  });

  final VoidCallback onOpenAll;
  final void Function(OrderFilter filter) onOpenFilter;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  '我的订单',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onOpenAll,
                  behavior: HitTestBehavior.opaque,
                  child: const Row(
                    children: [
                      Text(
                        '全部订单',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                for (var i = 0; i < profileOrderShortcuts.length; i++)
                  Expanded(
                    child: _OrderShortcutItem(
                      shortcut: profileOrderShortcuts[i],
                      onTap: () =>
                          onOpenFilter(profileOrderShortcuts[i].filter),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderShortcutItem extends StatelessWidget {
  const _OrderShortcutItem({required this.shortcut, required this.onTap});

  final ProfileOrderShortcut shortcut;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(shortcut.icon, size: 26, color: AppColors.textPrimary),
                if (shortcut.badgeCount > 0)
                  Positioned(
                    right: -8,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${shortcut.badgeCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              shortcut.label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({
    required this.title,
    required this.items,
    required this.onTap,
  });

  final String title;
  final List<ProfileMenuItem> items;
  final void Function(ProfileMenuItem item) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) const Divider(height: 1, indent: 52),
                ListTile(
                  leading: Icon(items[i].icon, color: AppColors.textPrimary),
                  title: Text(items[i].title),
                  subtitle: items[i].subtitle != null
                      ? Text(
                          items[i].subtitle!,
                          style: const TextStyle(fontSize: 12),
                        )
                      : null,
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textMuted,
                  ),
                  onTap: () => onTap(items[i]),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
