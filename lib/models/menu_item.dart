class MenuCategory {
  const MenuCategory({required this.id, required this.name, required this.items});

  final String id;
  final String name;
  final List<MenuItem> items;
}

class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.monthlySales,
    required this.praiseRate,
    required this.price,
    required this.imageAsset,
    this.initialQuantity = 0,
  });

  final String id;
  final String name;
  final String description;
  final int monthlySales;
  final int praiseRate;
  final int price;
  final String imageAsset;
  final int initialQuantity;
}
