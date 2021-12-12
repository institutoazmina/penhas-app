import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

class TweetModel extends TweetEntity {
  final String? id;
  final String? userName;
  final int clientId;
  final String? createdAt;
  final int totalReply;
  final int totalLikes;
  final bool anonymous;
  final String? content;
  final String? avatar;
  final TweetMeta meta;
  final List<TweetEntity> lastReply;

  TweetModel({
    required this.id,
    required this.userName,
    required this.clientId,
    required this.createdAt,
    required this.totalReply,
    required this.totalLikes,
    required this.anonymous,
    required this.content,
    required this.avatar,
    required this.meta,
    required this.lastReply,
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
          lastReply: lastReply,
        );

  factory TweetModel.fromJson(Map<String, dynamic> jsonData) {
    final meta = jsonData['meta'] as Map<String, dynamic>;
    final tweetMeta = TweetMeta(
      liked: meta['liked'] == 1,
      owner: meta['owner'] == 1,
    );

    List<TweetModel> lastReply = [];
    if (jsonData['last_reply'] != null) {
      lastReply = [TweetModel.fromJson(jsonData['last_reply'] as Map<String, Object>)];
    }

    return TweetModel(
      id: jsonData['id'] as String?,
      userName: jsonData['name'] as String?,
      clientId: (jsonData['cliente_id'] as num).toInt(),
      createdAt: jsonData['created_at'] as String?,
      totalReply: (jsonData['qtde_comentarios'] as num).toInt(),
      totalLikes: (jsonData['qtde_likes'] as num).toInt(),
      anonymous: jsonData['anonimo'] != 0,
      content: jsonData['content'] as String?,
      avatar: jsonData['icon'] as String?,
      meta: tweetMeta,
      lastReply: lastReply,
    );
  }
}

class TweetRelatedNewsModel extends TweetRelatedNewsEntity {
  static TweetRelatedNewsEntity fromJson(Map<String, Object> jsonData) {
    final List<TweetNewsEntity> news = _parseNews(jsonData['news'] as List<Object>);

    return TweetRelatedNewsEntity(
      header: jsonData['header'] as String? ?? '',
      news: news,
    );
  }

  static List<TweetNewsModel> _parseNews(List<dynamic> news) {
    return news.map((e) => TweetNewsModel.fromJson(e)).toList();
  }
}

class TweetNewsGroupModel extends TweetNewsGroupEntity {
  static TweetNewsGroupEntity fromJson(Map<String, Object> jsonData) {
    final List<TweetNewsEntity> news = _parseNews(jsonData['news'] as List<Object>);

    return TweetNewsGroupEntity(
      header: jsonData['header'] as String? ?? '',
      news: news,
    );
  }

  static List<TweetNewsModel> _parseNews(List<dynamic> news) =>
      news.map((e) => TweetNewsModel.fromJson(e)).toList();
}

class TweetNewsModel extends TweetNewsEntity {
  static TweetNewsEntity fromJson(Map<String, Object> jsonData) {
    return TweetNewsEntity(
      date: jsonData['date_str'] as String?,
      title: jsonData['title'] as String?,
      source: jsonData['source'] as String?,
      imageUri: jsonData['image'] as String?,
      newsUri: jsonData['href'] as String?,
    );
  }
}
