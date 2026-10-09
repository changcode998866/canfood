import '../models/menu_item.dart';
import '../models/restaurant.dart';
import 'mock_menu_songjian.dart';
import 'mock_products.dart';

List<MenuCategory> menuForRestaurant(Restaurant restaurant) {
  if (restaurant.name == '松间小馆') {
    return songjianMenu;
  }

  return [
    MenuCategory(
      id: 'recommended',
      name: '推荐',
      items: [
        for (final product in products)
          MenuItem(
            id: product.name,
            name: product.name,
            description: product.description,
            monthlySales: 120,
            praiseRate: 95,
            price: product.price.round(),
            imageAsset: product.imageAsset,
          ),
      ],
    ),
  ];
}

String? restaurantSlogan(Restaurant restaurant) {
  if (restaurant.name == '松间小馆') {
    return songjianSlogan;
  }
  return null;
}

String? restaurantPromoLine(Restaurant restaurant) {
  for (final tag in restaurant.tags) {
    if (tag.highlighted) {
      return '${tag.label} · 本店精选优惠';
    }
  }
  return null;
}
