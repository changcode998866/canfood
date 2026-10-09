import 'package:flutter/material.dart';

import '../data/mock_discover.dart';
import '../data/mock_restaurants.dart';
import '../models/discover_content.dart';
import '../theme/app_colors.dart';
import '../widgets/discover_feature_card.dart';
import '../widgets/discover_story_tile.dart';
import '../widgets/restaurant_card.dart';
import 'restaurant_order_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String _selectedTopicId = discoverTopics.first.id;

  List<DiscoverStory> get _filteredStories {
    if (_selectedTopicId == 'all') {
      return discoverStories;
    }
    return discoverStories
        .where((story) => story.topicId == _selectedTopicId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final stories = _filteredStories;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const _DiscoverHeader(),
        const SizedBox(height: 14),
        const _DiscoverSearchBar(),
        const SizedBox(height: 16),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: discoverTopics.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final topic = discoverTopics[index];
              final selected = topic.id == _selectedTopicId;
              return GestureDetector(
                onTap: () => setState(() => _selectedTopicId = topic.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primarySoft
                        : AppColors.chipInactive,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    topic.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 22),
        const _SectionHeader(title: '编辑精选'),
        const SizedBox(height: 12),
        SizedBox(
          height: 168,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: discoverFeatures.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final feature = discoverFeatures[index];
              return DiscoverFeatureCard(
                feature: feature,
                onTap: () => _showToast(context, '打开专题：${feature.title}'),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader(title: '热门专题'),
        const SizedBox(height: 12),
        Row(
          children: [
            for (var i = 0; i < discoverTopicCards.length; i++) ...[
              if (i > 0) const SizedBox(width: 12),
              Expanded(
                child: _TopicGridCard(
                  card: discoverTopicCards[i],
                  onTap: () => _showToast(
                    context,
                    '进入 ${discoverTopicCards[i].title}',
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        const _SectionHeader(title: '探店笔记'),
        const SizedBox(height: 12),
        if (stories.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '该话题暂无笔记，换个标签看看',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted),
            ),
          )
        else
          ...stories.map(
            (story) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DiscoverStoryTile(
                story: story,
                onTap: () => _showToast(context, '阅读：${story.title}'),
              ),
            ),
          ),
        const SizedBox(height: 12),
        const _SectionHeader(title: '附近值得去', actionText: '地图模式'),
        const SizedBox(height: 12),
        ...nearbyRestaurants.map(
          (restaurant) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: RestaurantCard(
              restaurant: restaurant,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) =>
                        RestaurantOrderPage(restaurant: restaurant),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}

class _DiscoverHeader extends StatelessWidget {
  const _DiscoverHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '发现',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 6),
        Text(
          '探索专题、笔记与城市里的隐藏美味',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _DiscoverSearchBar extends StatelessWidget {
  const _DiscoverSearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: AppColors.textMuted, size: 22),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '搜索专题、笔记、餐厅',
              style: TextStyle(color: AppColors.textMuted, fontSize: 14),
            ),
          ),
          Icon(Icons.tune_rounded, color: AppColors.textSecondary, size: 22),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionText});

  final String title;
  final String? actionText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        if (actionText != null) ...[
          Text(
            actionText!,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(
            Icons.chevron_right_rounded,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ],
      ],
    );
  }
}

class _TopicGridCard extends StatelessWidget {
  const _TopicGridCard({required this.card, this.onTap});

  final DiscoverTopicCard card;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 0.92,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(card.imageAsset, fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.62),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      card.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      card.participantCount,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.88),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
