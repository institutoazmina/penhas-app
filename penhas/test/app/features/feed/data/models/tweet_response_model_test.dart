import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  TweetSessionMondel tweetSessionMondel;
  setUp(() {});

  group('TweetResponseModel', () {
    test('tweets should be a subclass of TweetSessionEntity', () async {
      // arrange
      tweetSessionMondel = TweetSessionMondel(
        false,
        TweetSessionOrder.latestFirst,
        [],
      );
      // assert
      expect(tweetSessionMondel, isA<TweetSessionEntity>());
    });

    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'feed/retrieve_response.json');
      final TweetSessionEntity expectedSession =
          TweetSessionMondel(true, TweetSessionOrder.latestFirst, [
        TweetEntity(
          id: '200528T2055380001',
          userName: 'penhas',
          clientId: 551,
          createdAt: '2020-05-28 20:55:38',
          totalReply: 0,
          totalLikes: 0,
          anonymous: false,
          content: 'sleep 7',
          avatar: 'https:\/\/elasv2-api.appcivico.com\/avatar\/padrao.svg',
          meta: TweetMeta(liked: false, owner: true),
        ),
        TweetEntity(
          id: '200528T2055370004',
          userName: 'penhas',
          clientId: 551,
          createdAt: '2020-05-28 20:55:37',
          totalReply: 0,
          totalLikes: 0,
          anonymous: false,
          content: 'sleep 6',
          avatar: 'https:\/\/elasv2-api.appcivico.com\/avatar\/padrao.svg',
          meta: TweetMeta(liked: false, owner: true),
        ),
      ]);
      // act
      final result = TweetSessionMondel.fromJson(jsonData);
      // assert
      expect(expectedSession, result);
    });
  });
}
