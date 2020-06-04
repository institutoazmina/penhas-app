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
  final TweetEntity lastReplay;

  TweetModel(
    this.id,
    this.userName,
    this.clientId,
    this.createdAt,
    this.totalReply,
    this.totalLikes,
    this.anonymous,
    this.content,
    this.avatar,
    this.meta,
    this.lastReplay,
  ) : super(
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
          lastReplay: lastReplay,
        );

  factory TweetModel.fromJson(Map<String, Object> jsonData) {
    final meta = jsonData['meta'] as Map<String, Object>;
    final tweetMeta = TweetMeta(
      liked: meta['liked'] == 1 ?? false,
      owner: meta['owner'] == 1 ?? false,
    );

    TweetModel lastReply;
    if (jsonData['last_reply'] != null) {
      lastReply = TweetModel.fromJson(jsonData['last_reply']);
    }

    return TweetModel(
        jsonData['id'],
        jsonData['name'],
        (jsonData['cliente_id'] as num).toInt(),
        jsonData['created_at'],
        (jsonData['qtde_comentarios'] as num).toInt(),
        (jsonData['qtde_likes'] as num).toInt(),
        jsonData['anonimo'] != 0,
        jsonData['content'],
        jsonData['icon'],
        tweetMeta,
        lastReply);
  }
}
