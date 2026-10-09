import 'package:flutter/material.dart';

import '../data/mock_orders.dart';
import '../models/food_order.dart';
import '../theme/app_colors.dart';
import '../widgets/order_card.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key, this.initialFilter = OrderFilter.all});

  final OrderFilter initialFilter;

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late OrderFilter _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
  }

  @override
  void didUpdateWidget(covariant OrdersPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialFilter != widget.initialFilter) {
      _selectedFilter = widget.initialFilter;
    }
  }

  List<FoodOrder> get _filteredOrders => mockOrders
      .where((order) => order.matchesFilter(_selectedFilter))
      .toList();

  @override
  Widget build(BuildContext context) {
    final orders = _filteredOrders;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '订单',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                '查看支付、配送进度与历史记录',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: orderFilters.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final filter = orderFilters[index];
                    final selected = filter == _selectedFilter;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = filter),
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
                          filter.label,
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
            ],
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: orders.isEmpty
              ? _OrdersEmptyState(filter: _selectedFilter)
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: orders.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return OrderCard(
                      order: order,
                      onPrimaryAction: () => _handlePrimary(context, order),
                      onSecondaryAction: () =>
                          _handleSecondary(context, order),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _handlePrimary(BuildContext context, FoodOrder order) {
    final message = switch (order.status) {
      OrderStatus.pendingPayment => '跳转支付：${order.id}',
      OrderStatus.preparing || OrderStatus.delivering => '查看配送进度',
      OrderStatus.completed => '再来一单：${order.restaurantName}',
      OrderStatus.refunded => '已删除 ${order.id}',
    };
    _toast(context, message);
  }

  void _handleSecondary(BuildContext context, FoodOrder order) {
    final message = switch (order.status) {
      OrderStatus.pendingPayment => '已取消 ${order.id}',
      OrderStatus.preparing => '联系 ${order.restaurantName}',
      OrderStatus.delivering => '联系骑手',
      OrderStatus.completed => '打开评价页',
      OrderStatus.refunded => '',
    };
    if (message.isNotEmpty) {
      _toast(context, message);
    }
  }

  void _toast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}

class _OrdersEmptyState extends StatelessWidget {
  const _OrdersEmptyState({required this.filter});

  final OrderFilter filter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.receipt_long_outlined,
              size: 56,
              color: AppColors.primary,
            ),
            const SizedBox(height: 12),
            Text(
              filter == OrderFilter.all ? '暂无订单' : '没有${filter.label}订单',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '下单后可在订单页查看进度',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
