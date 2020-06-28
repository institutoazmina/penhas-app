import 'package:meta/meta.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

class TweetFilterSessionModel extends TweetFilterSessionEntity {
  final List<TweetFilterCategory> categories;
  final List<TweetFilterTag> tags;

  TweetFilterSessionModel({
    @required this.categories,
    @required this.tags,
  }) : super(categories: categories, tags: tags);

  factory TweetFilterSessionModel.fromJson(Map<String, Object> jsonData) {
    final List<Object> tagsObject = jsonData['tags'];
    final List<Object> categoriesObject = jsonData['categories'];
    final List<TweetFilterCategory> categories = categoriesObject
        .map((e) => e as Map<String, Object>)
        .map((e) => TweetFilterCategoryModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    final List<TweetFilterTag> tags = tagsObject
        .map((e) => e as Map<String, Object>)
        .map((e) => TweetFilterTagModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    return TweetFilterSessionModel(
      categories: categories,
      tags: tags,
    );
  }
}

class TweetFilterCategoryModel {
  static TweetFilterCategory fromJson(Map<String, Object> jsonData) {
    if (jsonData == null) return null;
    return TweetFilterCategory(
      id: jsonData['value'],
      label: jsonData['label'],
      isDefault: (jsonData['default'] as num) == 1 ?? false,
    );
  }
}

class TweetFilterTagModel {
  static TweetFilterTag fromJson(Map<String, Object> jsonData) {
    if (jsonData == null) return null;
    return TweetFilterTag(
      id: "${jsonData['id']}",
      title: jsonData['title'],
    );
  }
}
