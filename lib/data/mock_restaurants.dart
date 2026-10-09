import '../models/restaurant.dart';

const heroBannerAsset = 'assets/images/hero_lunch.jpg';

const List<Restaurant> nearbyRestaurants = [
  Restaurant(
    name: '松间小馆',
    category: '家常菜',
    rating: 4.9,
    monthlySales: '1,200+',
    averagePrice: 35,
    deliveryMinutesMin: 25,
    deliveryMinutesMax: 35,
    distanceKm: 0.8,
    deliveryFee: 4,
    imageAsset: 'assets/images/restaurant_songjian.jpg',
    tags: [
      RestaurantTag(label: '满 ¥60 减 ¥8', highlighted: true),
      RestaurantTag(label: '放心好店'),
    ],
  ),
  Restaurant(
    name: '晨光食堂',
    category: '轻食',
    rating: 4.8,
    monthlySales: '860+',
    averagePrice: 28,
    deliveryMinutesMin: 20,
    deliveryMinutesMax: 30,
    distanceKm: 1.2,
    deliveryFee: 3,
    imageAsset: 'assets/images/restaurant_chenguang.jpg',
    tags: [
      RestaurantTag(label: '新客立减 ¥6', highlighted: true),
    ],
  ),
];
