import 'package:meta/meta.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

class TweetModel extends TweetEntity {
  final String id;
  final String userName;
  final int clientId;
  final String createdAt;
  final int totalReply;
  final int totalLikes;
  final bool anonymous;
  final String content;
  final String avatar;
  final TweetMeta meta;
  final List<TweetEntity> lastReply;

  TweetModel({
    @required this.id,
    @required this.userName,
    @required this.clientId,
    @required this.createdAt,
    @required this.totalReply,
    @required this.totalLikes,
    @required this.anonymous,
    @required this.content,
    @required this.avatar,
    @required this.meta,
    @required this.lastReply,
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

  factory TweetModel.fromJson(Map<String, Object> jsonData) {
    final meta = jsonData['meta'] as Map<String, Object>;
    final tweetMeta = TweetMeta(
      liked: meta['liked'] == 1 ?? false,
      owner: meta['owner'] == 1 ?? false,
    );

    List<TweetModel> lastReply = List<TweetModel>();
    if (jsonData['last_reply'] != null) {
      lastReply = [TweetModel.fromJson(jsonData['last_reply'])];
    }

    return TweetModel(
      id: jsonData['id'],
      userName: jsonData['name'],
      clientId: (jsonData['cliente_id'] as num).toInt(),
      createdAt: jsonData['created_at'],
      totalReply: (jsonData['qtde_comentarios'] as num).toInt(),
      totalLikes: (jsonData['qtde_likes'] as num).toInt(),
      anonymous: jsonData['anonimo'] != 0,
      content: jsonData['content'],
      avatar: jsonData['icon'],
      meta: tweetMeta,
      lastReply: lastReply,
    );
  }
}

class TweetRelatedNewsModel extends TweetRelatedNews {
  static TweetRelatedNews fromJson(Map<String, Object> jsonData) {
    final List<TweetNews> news = _parseNews(jsonData['news']);

    return TweetRelatedNews(
      header: jsonData['header'] ?? '',
      news: news,
    );
  }

  static List<TweetNews> _parseNews(List<Object> news) {
    return news
        .map((e) => e as Map<String, Object>)
        .map((e) => TweetNewsModel.fromJson(e))
        .toList();
  }
}

class TweetNewsGroupModel extends TweetNewsGroup {
  static TweetNewsGroup fromJson(Map<String, Object> jsonData) {
    final List<TweetNews> news = _parseNews(jsonData['news']);

    return TweetNewsGroup(
      header: jsonData['header'] ?? '',
      news: news,
    );
  }

  static List<TweetNews> _parseNews(List<Object> news) {
    return news
        .map((e) => e as Map<String, Object>)
        .map((e) => TweetNewsModel.fromJson(e))
        .toList();
  }
}

class TweetNewsModel extends TweetNews {
  static TweetNews fromJson(Map<String, Object> jsonData) {
    return TweetNews(
      date: jsonData['date_str'],
      title: jsonData['title'],
      source: jsonData['source'],
      imageUri: jsonData['image'],
      newsUri: jsonData['href'],
    );
  }
}
