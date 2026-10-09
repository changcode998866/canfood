import 'package:flutter/material.dart';

import '../data/menu_for_restaurant.dart';
import '../data/mock_menu_songjian.dart';
import '../models/menu_item.dart';
import '../models/restaurant.dart';
import '../theme/app_colors.dart';
import '../widgets/menu_dish_tile.dart';

class RestaurantOrderPage extends StatefulWidget {
  const RestaurantOrderPage({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<RestaurantOrderPage> createState() => _RestaurantOrderPageState();
}

class _RestaurantOrderPageState extends State<RestaurantOrderPage> {
  static const _tabs = ['点餐', '评价 (328)', '商家'];

  late final List<MenuCategory> _menu = menuForRestaurant(widget.restaurant);
  late final Map<String, int> _quantities = _buildInitialQuantities();
  int _selectedCategory = 0;
  int _selectedTab = 0;

  Map<String, int> _buildInitialQuantities() {
    final quantities = <String, int>{};
    for (final category in _menu) {
      for (final item in category.items) {
        if (item.initialQuantity > 0) {
          quantities[item.id] = item.initialQuantity;
        }
      }
    }
    return quantities;
  }

  int get _totalItems =>
      _quantities.values.fold<int>(0, (sum, count) => sum + count);

  int get _subtotal {
    var total = 0;
    for (final category in _menu) {
      for (final item in category.items) {
        total += (_quantities[item.id] ?? 0) * item.price;
      }
    }
    return total;
  }

  int get _discount => _subtotal >= 60 ? 8 : 0;

  void _setQuantity(String id, int value) {
    setState(() {
      if (value <= 0) {
        _quantities.remove(id);
      } else {
        _quantities[id] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final promoLine =
        restaurantPromoLine(widget.restaurant) ?? songjianPromoText;
    final slogan = restaurantSlogan(widget.restaurant);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildTopBar(context),
          _RestaurantSummary(
            restaurant: widget.restaurant,
            promoLine: promoLine,
            slogan: slogan,
          ),
          _buildTabs(),
          Expanded(
            child: _selectedTab == 0
                ? _buildOrderingBody()
                : _PlaceholderTab(label: _tabs[_selectedTab]),
          ),
          _OrderCartBar(
            totalItems: _totalItems,
            foodTotal: _subtotal,
            deliveryFee: widget.restaurant.deliveryFee,
            discount: _discount,
            onCheckout: _totalItems == 0
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('即将进入结算')),
                    );
                  },
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 8, 0),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            ),
            Expanded(
              child: Text(
                widget.restaurant.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final selected = index == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  Text(
                    _tabs[index],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                      color: selected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 3,
                    width: selected ? 28 : 0,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildOrderingBody() {
    final category = _menu[_selectedCategory];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 92,
          child: ListView.builder(
            itemCount: _menu.length,
            itemBuilder: (context, index) {
              final selected = index == _selectedCategory;
              final name = _menu[index].name;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : AppColors.chipInactive,
                    border: selected
                        ? const Border(
                            left: BorderSide(
                              color: AppColors.primary,
                              width: 3,
                            ),
                          )
                        : null,
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      color: selected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      height: 1.3,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ColoredBox(
            color: Colors.white,
            child: category.items.isEmpty
                ? const Center(
                    child: Text(
                      '敬请期待',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.only(top: 12, bottom: 24),
                    children: [
                      if (category.id == 'signature') ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '招牌推荐',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '好味道，闭眼点',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ] else
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          child: Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      for (final item in category.items)
                        MenuDishTile(
                          item: item,
                          quantity: _quantities[item.id] ?? 0,
                          onIncrement: () =>
                              _setQuantity(item.id, (_quantities[item.id] ?? 0) + 1),
                          onDecrement: () =>
                              _setQuantity(item.id, (_quantities[item.id] ?? 0) - 1),
                        ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _RestaurantSummary extends StatelessWidget {
  const _RestaurantSummary({
    required this.restaurant,
    required this.promoLine,
    this.slogan,
  });

  final Restaurant restaurant;
  final String promoLine;
  final String? slogan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RestaurantLogo(restaurant: restaurant),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.displayName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        Text(
                          ' ${restaurant.rating.toStringAsFixed(1)}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '月售 ${restaurant.monthlySales}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${restaurant.distanceKm} 公里',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '配送 ¥${restaurant.deliveryFee} · 约 '
                      '${restaurant.deliveryMinutesMin}-'
                      '${restaurant.deliveryMinutesMax} 分钟送达',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    promoLine,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Text(
                  '领券',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: AppColors.primary.withValues(alpha: 0.8),
                ),
              ],
            ),
          ),
          if (slogan != null) ...[
            const SizedBox(height: 10),
            Text(
              slogan!,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.45,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _RestaurantLogo extends StatelessWidget {
  const _RestaurantLogo({required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    if (restaurant.name == '松间小馆') {
      return Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFF2F4A3A),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: const Text(
          '松间\n一日三餐',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            height: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        restaurant.imageAsset,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$label 内容开发中',
        style: const TextStyle(color: AppColors.textMuted),
      ),
    );
  }
}

class _OrderCartBar extends StatelessWidget {
  const _OrderCartBar({
    required this.totalItems,
    required this.foodTotal,
    required this.deliveryFee,
    required this.discount,
    this.onCheckout,
  });

  final int totalItems;
  final int foodTotal;
  final int deliveryFee;
  final int discount;
  final VoidCallback? onCheckout;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (discount > 0)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.primarySoft,
            child: Text(
              '已享满减 ¥$discount，今天也要好好吃饭',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Material(
          elevation: 12,
          color: Colors.white,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3D3D3D),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          totalItems > 0
                              ? Icons.shopping_bag_outlined
                              : Icons.shopping_bag_outlined,
                          color: Colors.white,
                        ),
                      ),
                      if (totalItems > 0)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            child: Text(
                              '$totalItems',
                              textAlign: TextAlign.center,
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          totalItems == 0 ? '¥0' : '¥$foodTotal',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: totalItems == 0
                                ? AppColors.textMuted
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          totalItems == 0
                              ? '尚未选择商品'
                              : '另需配送费 ¥$deliveryFee · 已选 $totalItems 份',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: onCheckout,
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: AppColors.textMuted,
                        minimumSize: const Size(0, 44),
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: const Text('去结算'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
