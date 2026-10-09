class Restaurant {
  const Restaurant({
    required this.name,
    required this.category,
    required this.rating,
    required this.monthlySales,
    required this.averagePrice,
    required this.deliveryMinutesMin,
    required this.deliveryMinutesMax,
    required this.distanceKm,
    required this.deliveryFee,
    required this.imageAsset,
    required this.tags,
  });

  final String name;
  final String category;
  final double rating;
  final String monthlySales;
  final int averagePrice;
  final int deliveryMinutesMin;
  final int deliveryMinutesMax;
  final double distanceKm;
  final int deliveryFee;
  final String imageAsset;
  final List<RestaurantTag> tags;

  String get displayName => '$name · $category';
}

class RestaurantTag {
  const RestaurantTag({required this.label, this.highlighted = false});

  final String label;
  final bool highlighted;
}
