import '../../domain/entities/tweet_filter_session_entity.dart';

class TweetFilterSessionModel extends TweetFilterSessionEntity {
  const TweetFilterSessionModel({
    required super.categories,
    required super.tags,
  });

  factory TweetFilterSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final List<dynamic> tagsObject = jsonData['tags'];
    final List<dynamic> categoriesObject = jsonData['categories'];
    final List<TweetFilterEntity> categories = categoriesObject
        .map((e) => TweetFilterEntityModel.fromJson(e))
        .nonNulls
        .toList();

    final List<TweetFilterEntity> tags = tagsObject
        .map((e) => TweetFilterEntityModel.fromJson(e))
        .nonNulls
        .toList();

    return TweetFilterSessionModel(
      categories: categories,
      tags: tags,
    );
  }
}

class TweetFilterEntityModel {
  static TweetFilterEntity? fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) return null;
    return TweetFilterEntity(
      id: jsonData['value'] ?? "${jsonData['id']}",
      label: jsonData['label'] ?? jsonData['title'],
      isSelected: jsonData['default'] == 1,
    );
  }
}
