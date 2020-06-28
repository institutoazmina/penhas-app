import 'package:meta/meta.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

class TweetFilterSessionModel extends TweetFilterSessionEntity {
  final List<TweetFilterEntity> categories;
  final List<TweetFilterEntity> tags;

  TweetFilterSessionModel({
    @required this.categories,
    @required this.tags,
  }) : super(categories: categories, tags: tags);

  factory TweetFilterSessionModel.fromJson(Map<String, Object> jsonData) {
    final List<Object> tagsObject = jsonData['tags'];
    final List<Object> categoriesObject = jsonData['categories'];
    final List<TweetFilterEntity> categories = categoriesObject
        .map((e) => e as Map<String, Object>)
        .map((e) => TweetFilterEntityModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    final List<TweetFilterEntity> tags = tagsObject
        .map((e) => e as Map<String, Object>)
        .map((e) => TweetFilterEntityModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    return TweetFilterSessionModel(
      categories: categories,
      tags: tags,
    );
  }
}

class TweetFilterEntityModel {
  static TweetFilterEntity fromJson(Map<String, Object> jsonData) {
    if (jsonData == null) return null;
    return TweetFilterEntity(
      id: jsonData['value'] ?? "${jsonData['id']}",
      label: jsonData['label'] ?? jsonData['title'],
      isSelected: (jsonData['default'] as num) == 1 ?? false,
    );
  }
}
