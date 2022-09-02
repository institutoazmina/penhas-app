import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

class TweetModel extends TweetEntity {
  TweetModel({
    required String? id,
    required String? userName,
    required int clientId,
    required String? createdAt,
    required int totalReply,
    required int totalLikes,
    required bool anonymous,
    required String? content,
    required String avatar,
    required TweetMeta meta,
    String? parentId,
    required List<TweetModel> lastReply,
  }) : super(
          id: id,
          userName: userName,
          clientId: clientId,
          createdAt: createdAt,
          totalReply: totalReply,
          totalLikes: totalLikes,
          anonymous: anonymous,
          content: content,
          avatar: avatar,
          meta: meta,
          parentId: parentId,
          lastReply: lastReply,
        );

  factory TweetModel.fromJson(Map<String, dynamic> jsonData) {
    final meta = jsonData['meta'] as Map<String, dynamic>;
    final tweetMeta = TweetMeta(
      liked: meta['liked'] == 1,
      owner: meta['owner'] == 1,
      canReply: meta['can_reply'] == 1,
    );

    List<TweetModel> lastReply = [];
    if (jsonData['last_reply'] != null) {
      lastReply = [TweetModel.fromJson(jsonData['last_reply'])];
    }

    return TweetModel(
      id: jsonData['id'],
      userName: jsonData['name'],
      clientId: jsonData['cliente_id'],
      createdAt: jsonData['created_at'],
      totalReply: jsonData['qtde_comentarios'],
      totalLikes: jsonData['qtde_likes'],
      anonymous: jsonData['anonimo'] != 0,
      content: jsonData['content'],
      avatar: jsonData['icon'],
      meta: tweetMeta,
      parentId: meta['parent_id'],
      lastReply: lastReply,
    );
  }
}

class TweetRelatedNewsModel extends TweetRelatedNewsEntity {
  TweetRelatedNewsModel({
    required String header,
    required List<TweetNewsModel> news,
  }) : super(header: header, news: news);

  factory TweetRelatedNewsModel.fromJson(Map<String, dynamic> jsonData) {
    final List<TweetNewsModel> news = _parseNews(jsonData['news']);

    return TweetRelatedNewsModel(
      header: jsonData['header'] ?? '',
      news: news,
    );
  }

  static List<TweetNewsModel> _parseNews(List<dynamic> news) {
    return news.map((e) => TweetNewsModel.fromJson(e)).toList();
  }
}

class TweetNewsGroupModel extends TweetNewsGroupEntity {
  TweetNewsGroupModel({
    required String header,
    required List<TweetNewsModel> news,
  }) : super(header: header, news: news);

  factory TweetNewsGroupModel.fromJson(Map<String, dynamic> jsonData) {
    final List<TweetNewsModel> news = _parseNews(jsonData['news']);

    return TweetNewsGroupModel(
      header: jsonData['header'] as String? ?? '',
      news: news,
    );
  }

  static List<TweetNewsModel> _parseNews(List<dynamic> news) =>
      news.map((e) => TweetNewsModel.fromJson(e)).toList();
}

class TweetNewsModel extends TweetNewsEntity {
  TweetNewsModel({
    String? date,
    required String newsUri,
    String? imageUri,
    String? source,
    required String title,
  }) : super(
          date: date,
          newsUri: newsUri,
          imageUri: imageUri,
          source: source,
          title: title,
        );

  factory TweetNewsModel.fromJson(Map<String, dynamic> jsonData) =>
      TweetNewsModel(
        date: jsonData['date_str'],
        title: jsonData['title'],
        source: jsonData['source'],
        imageUri: jsonData['image'],
        newsUri: jsonData['href'],
      );
}
