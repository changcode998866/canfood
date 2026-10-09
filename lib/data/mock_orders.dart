import '../models/food_order.dart';

const orderFilters = [
  OrderFilter.all,
  OrderFilter.pendingPayment,
  OrderFilter.inProgress,
  OrderFilter.completed,
  OrderFilter.refund,
];

const mockOrders = [
  FoodOrder(
    id: 'ord_1001',
    restaurantName: '松间小馆',
    restaurantCategory: '家常菜',
    status: OrderStatus.delivering,
    items: [
      OrderLineItem(name: '招牌三杯鸡', quantity: 1),
      OrderLineItem(name: '蒜蓉杏鲍菇', quantity: 1),
      OrderLineItem(name: '东北大米饭', quantity: 2),
    ],
    foodTotal: 70,
    deliveryFee: 4,
    discount: 8,
    placedAtLabel: '今天 12:28',
    imageAsset: 'assets/images/restaurant_songjian.jpg',
  ),
  FoodOrder(
    id: 'ord_1002',
    restaurantName: '晨光食堂',
    restaurantCategory: '轻食',
    status: OrderStatus.completed,
    items: [
      OrderLineItem(name: '轻食沙拉碗', quantity: 1),
      OrderLineItem(name: '鲜榨橙汁', quantity: 1),
    ],
    foodTotal: 46,
    deliveryFee: 3,
    discount: 6,
    placedAtLabel: '昨天 18:06',
    imageAsset: 'assets/images/restaurant_chenguang.jpg',
  ),
  FoodOrder(
    id: 'ord_1003',
    restaurantName: '松间小馆',
    restaurantCategory: '家常菜',
    status: OrderStatus.pendingPayment,
    items: [
      OrderLineItem(name: '红烧牛腩', quantity: 1),
      OrderLineItem(name: '东北大米饭', quantity: 1),
    ],
    foodTotal: 46,
    deliveryFee: 4,
    discount: 0,
    placedAtLabel: '今天 11:05',
    imageAsset: 'assets/images/restaurant_songjian.jpg',
  ),
  FoodOrder(
    id: 'ord_0998',
    restaurantName: '晨光食堂',
    restaurantCategory: '轻食',
    status: OrderStatus.refunded,
    items: [
      OrderLineItem(name: '能量碗', quantity: 1),
    ],
    foodTotal: 32,
    deliveryFee: 3,
    discount: 0,
    placedAtLabel: '3月18日 13:20',
    imageAsset: 'assets/images/restaurant_chenguang.jpg',
  ),
];
