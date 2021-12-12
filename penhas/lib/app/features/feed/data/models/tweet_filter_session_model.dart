import 'package:collection/collection.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

class TweetFilterSessionModel extends TweetFilterSessionEntity {
  final List<TweetFilterEntity> categories;
  final List<TweetFilterEntity> tags;

  TweetFilterSessionModel({
    required this.categories,
    required this.tags,
  }) : super(categories: categories, tags: tags);

  factory TweetFilterSessionModel.fromJson(Map<String, Object> jsonData) {
    final List<Object> tagsObject = jsonData['tags'] as List<Object>;
    final List<Object> categoriesObject = jsonData['categories'] as List<Object>;
    final List<TweetFilterEntity> categories = categoriesObject
        .map((e) => TweetFilterEntityModel.fromJson(e))
        .whereNotNull()
        .toList();

    final List<TweetFilterEntity> tags = tagsObject
        .map((e) => TweetFilterEntityModel.fromJson(e))
        .whereNotNull()
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
      id: jsonData['value'] as String? ?? "${jsonData['id']}",
      label: jsonData['label'] as String? ?? jsonData['title'] as String?,
      isSelected: (jsonData['default'] as num?) == 1 ?? false,
    );
  }
}
