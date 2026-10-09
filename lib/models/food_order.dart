enum OrderStatus {
  pendingPayment,
  preparing,
  delivering,
  completed,
  refunded,
}

extension OrderStatusLabels on OrderStatus {
  String get label => switch (this) {
        OrderStatus.pendingPayment => '待支付',
        OrderStatus.preparing => '商家备餐中',
        OrderStatus.delivering => '配送中',
        OrderStatus.completed => '已完成',
        OrderStatus.refunded => '退款成功',
      };

  bool get isActive => this == OrderStatus.pendingPayment ||
      this == OrderStatus.preparing ||
      this == OrderStatus.delivering;
}

enum OrderFilter {
  all,
  pendingPayment,
  inProgress,
  completed,
  refund,
}

extension OrderFilterLabels on OrderFilter {
  String get label => switch (this) {
        OrderFilter.all => '全部',
        OrderFilter.pendingPayment => '待支付',
        OrderFilter.inProgress => '待配送',
        OrderFilter.completed => '已完成',
        OrderFilter.refund => '退款/售后',
      };
}

class OrderLineItem {
  const OrderLineItem({required this.name, required this.quantity});

  final String name;
  final int quantity;
}

class FoodOrder {
  const FoodOrder({
    required this.id,
    required this.restaurantName,
    required this.restaurantCategory,
    required this.status,
    required this.items,
    required this.foodTotal,
    required this.deliveryFee,
    required this.discount,
    required this.placedAtLabel,
    required this.imageAsset,
  });

  final String id;
  final String restaurantName;
  final String restaurantCategory;
  final OrderStatus status;
  final List<OrderLineItem> items;
  final int foodTotal;
  final int deliveryFee;
  final int discount;
  final String placedAtLabel;
  final String imageAsset;

  String get displayRestaurant => '$restaurantName · $restaurantCategory';

  int get payable => foodTotal - discount + deliveryFee;

  int get itemCount =>
      items.fold<int>(0, (sum, item) => sum + item.quantity);

  String get itemsSummary {
    if (items.isEmpty) {
      return '';
    }
    final first = items.first;
    final extra = itemCount - first.quantity;
    if (extra <= 0) {
      return '${first.name} 等${items.length}件';
    }
    return '${first.name} 等$itemCount件';
  }

  bool matchesFilter(OrderFilter filter) => switch (filter) {
        OrderFilter.all => true,
        OrderFilter.pendingPayment =>
          status == OrderStatus.pendingPayment,
        OrderFilter.inProgress =>
          status == OrderStatus.preparing ||
              status == OrderStatus.delivering,
        OrderFilter.completed => status == OrderStatus.completed,
        OrderFilter.refund => status == OrderStatus.refunded,
      };
}
