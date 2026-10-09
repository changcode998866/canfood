import '../models/discover_content.dart';

const discoverTopics = [
  DiscoverTopic(id: 'all', label: '全部'),
  DiscoverTopic(id: 'explore', label: '探店'),
  DiscoverTopic(id: 'brunch', label: '周末 Brunch'),
  DiscoverTopic(id: 'light', label: '轻食'),
  DiscoverTopic(id: 'coffee', label: '咖啡'),
  DiscoverTopic(id: 'solo', label: '一人食'),
];

const discoverFeatures = [
  DiscoverFeature(
    id: 'winter_pot',
    tag: '食光周刊',
    title: '冬日暖锅地图',
    subtitle: '8 家本地人反复回购的锅物料理',
    imageAsset: 'assets/images/discover_feature_winter.jpg',
  ),
  DiscoverFeature(
    id: 'brunch_guide',
    tag: '周末指南',
    title: '慢下来吃一顿 Brunch',
    subtitle: '阳光、咖啡和刚出炉的可颂',
    imageAsset: 'assets/images/discover_feature_brunch.jpg',
  ),
];

const discoverTopicCards = [
  DiscoverTopicCard(
    id: 'noodle',
    title: '面食星人集合',
    participantCount: '2.3 万人参与',
    imageAsset: 'assets/images/discover_topic_noodle.jpg',
  ),
  DiscoverTopicCard(
    id: 'coffee',
    title: '城市咖啡漫游',
    participantCount: '1.8 万人参与',
    imageAsset: 'assets/images/discover_topic_coffee.jpg',
  ),
];

const discoverStories = [
  DiscoverStory(
    id: 'story_1',
    author: '阿南',
    title: '城西这条街，藏着三家宝藏小馆',
    excerpt: '从家常小炒到深夜食堂，步行 10 分钟就能吃遍…',
    likes: 1286,
    imageAsset: 'assets/images/discover_story_1.jpg',
    topicId: 'explore',
  ),
  DiscoverStory(
    id: 'story_2',
    author: '小鹿',
    title: '一人食也不将就的午餐方案',
    excerpt: '忙碌工作日，这三家轻食店让我重新爱上外卖…',
    likes: 942,
    imageAsset: 'assets/images/discover_story_2.jpg',
    topicId: 'light',
  ),
  DiscoverStory(
    id: 'story_3',
    author: '食光编辑部',
    title: '杭州周末 Brunch 路线推荐',
    excerpt: '从西溪到钱江新城，4 站搞定你的慢早晨…',
    likes: 2104,
    imageAsset: 'assets/images/discover_feature_brunch.jpg',
    topicId: 'brunch',
  ),
];
