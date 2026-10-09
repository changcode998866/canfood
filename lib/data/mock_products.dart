import '../models/product.dart';

const List<Product> products = [
  Product(
    name: '汉堡套餐',
    description: '美味的汉堡配薯条和饮料',
    price: 25.0,
    imageAsset: 'assets/images/burger_meal.jpg',
  ),
  Product(
    name: '煎饼套餐',
    description: '香脆的煎饼配豆浆和水果',
    price: 20.0,
    imageAsset: 'assets/images/pancake_meal.jpg',
  ),
  Product(
    name: '冰淇淋套餐',
    description: '冰凉的冰淇淋配水果和薯条',
    price: 30.0,
    imageAsset: 'assets/images/ice_cream_meal.jpg',
  ),
  Product(
    name: '饮料套餐',
    description: '美味的饮料配薯条和冰淇淋',
    price: 25.0,
    imageAsset: 'assets/images/drink_meal.jpg',
  ),
];

const String promoBannerAsset = 'assets/images/promo_banner.jpg';
