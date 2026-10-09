import '../models/menu_item.dart';

const songjianSlogan = '每日鲜做，不负三餐。用当季食材，做熟悉的家常味。';

const songjianPromoText = '满 ¥60 减 ¥8 · 本店精选优惠';

const List<MenuCategory> songjianMenu = [
  MenuCategory(
    id: 'signature',
    name: '招牌推荐',
    items: [
      MenuItem(
        id: 'sanbei_chicken',
        name: '招牌三杯鸡',
        description: '鲜嫩鸡腿肉 · 九层塔提香',
        monthlySales: 386,
        praiseRate: 98,
        price: 40,
        imageAsset: 'assets/images/dish_sanbei_chicken.jpg',
        initialQuantity: 1,
      ),
      MenuItem(
        id: 'garlic_mushroom',
        name: '蒜蓉杏鲍菇',
        description: '爽脆杏鲍菇 · 蒜香浓郁',
        monthlySales: 268,
        praiseRate: 97,
        price: 22,
        imageAsset: 'assets/images/dish_garlic_mushroom.jpg',
        initialQuantity: 1,
      ),
      MenuItem(
        id: 'braised_beef',
        name: '红烧牛腩',
        description: '慢炖牛腩 · 酱香入味',
        monthlySales: 192,
        praiseRate: 96,
        price: 42,
        imageAsset: 'assets/images/dish_braised_beef.jpg',
      ),
      MenuItem(
        id: 'northeast_rice',
        name: '东北大米饭',
        description: '颗粒分明 · 软糯香甜',
        monthlySales: 520,
        praiseRate: 99,
        price: 4,
        imageAsset: 'assets/images/dish_rice.jpg',
        initialQuantity: 2,
      ),
    ],
  ),
  MenuCategory(id: 'hot', name: '人气热菜', items: []),
  MenuCategory(id: 'vegetable', name: '时令蔬菜', items: []),
  MenuCategory(id: 'staple', name: '米饭主食', items: []),
  MenuCategory(id: 'drink', name: '饮品小食', items: []),
];
