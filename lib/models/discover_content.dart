class DiscoverTopic {
  const DiscoverTopic({required this.id, required this.label});

  final String id;
  final String label;
}

class DiscoverFeature {
  const DiscoverFeature({
    required this.id,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });

  final String id;
  final String tag;
  final String title;
  final String subtitle;
  final String imageAsset;
}

class DiscoverTopicCard {
  const DiscoverTopicCard({
    required this.id,
    required this.title,
    required this.participantCount,
    required this.imageAsset,
  });

  final String id;
  final String title;
  final String participantCount;
  final String imageAsset;
}

class DiscoverStory {
  const DiscoverStory({
    required this.id,
    required this.author,
    required this.title,
    required this.excerpt,
    required this.likes,
    required this.imageAsset,
    required this.topicId,
  });

  final String id;
  final String author;
  final String title;
  final String excerpt;
  final int likes;
  final String imageAsset;
  final String topicId;
}
