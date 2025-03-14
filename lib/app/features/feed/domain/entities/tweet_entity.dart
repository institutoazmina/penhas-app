import 'package:equatable/equatable.dart';

import 'tweet_badge_entity.dart';

abstract class TweetTiles extends Equatable {}

class TweetEntity extends TweetTiles {
  TweetEntity({
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
    this.parentId,
    this.lastReply = const [],
    required this.badges,
  });

  final String id;
  final String? parentId;
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
  final List<TweetBadgeEntity> badges;

  @override
  List<Object?> get props => [
        id,
        meta,
        avatar,
        content,
        userName,
        clientId,
        anonymous,
        createdAt,
        totalReply,
        totalLikes,
        parentId,
        lastReply,
        badges,
      ];

  TweetEntity copyWith({
    String? id,
    String? userName,
    int? clientId,
    String? createdAt,
    int? totalReply,
    int? totalLikes,
    bool? anonymous,
    String? content,
    String? avatar,
    TweetMeta? meta,
    String? parentId,
    List<TweetEntity>? lastReply,
    List<TweetBadgeEntity>? badges,
  }) {
    return TweetEntity(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      clientId: clientId ?? this.clientId,
      createdAt: createdAt ?? this.createdAt,
      totalReply: totalReply ?? this.totalReply,
      totalLikes: totalLikes ?? this.totalLikes,
      anonymous: anonymous ?? this.anonymous,
      content: content ?? this.content,
      avatar: avatar ?? this.avatar,
      meta: meta ?? this.meta,
      parentId: parentId ?? this.parentId,
      lastReply: lastReply ?? this.lastReply,
      badges: badges ?? this.badges,
    );
  }
}

class TweetMeta extends Equatable {
  const TweetMeta({
    required this.liked,
    required this.owner,
    this.canReply = true,
  });

  final bool liked;
  final bool owner;
  final bool canReply;

  @override
  List<Object?> get props => [liked, owner, canReply];
}

class TweetNewsGroupEntity extends TweetTiles {
  TweetNewsGroupEntity({required this.header, required this.news});

  final String header;
  final List<TweetNewsEntity> news;

  @override
  List<dynamic> get props => [header, news];
}

class TweetNewsEntity extends TweetTiles {
  TweetNewsEntity({
    required this.date,
    required this.newsUri,
    required this.imageUri,
    required this.source,
    required this.title,
  });

  final String? date;
  final String newsUri;
  final String? imageUri;
  final String? source;
  final String title;

  @override
  List<Object?> get props => [date, newsUri, imageUri, source, title];
}

class TweetRelatedNewsEntity extends TweetTiles {
  TweetRelatedNewsEntity({required this.header, required this.news});

  final String header;
  final List<TweetNewsEntity> news;

  @override
  List<Object?> get props => [header, news];
}
