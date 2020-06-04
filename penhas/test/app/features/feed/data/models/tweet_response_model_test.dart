import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  TweetSessionModel tweetSessionMondel;
  setUp(() {});

  group('TweetResponseModel', () {
    test('tweets should be a subclass of TweetSessionEntity', () async {
      // arrange
      tweetSessionMondel = TweetSessionModel(
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
          TweetSessionModel(true, TweetSessionOrder.latestFirst, [
        TweetModel(
          '200528T2055380001',
          'penhas',
          551,
          '2020-05-28 20:55:38',
          0,
          0,
          false,
          'sleep 7',
          'https:\/\/elasv2-api.appcivico.com\/avatar\/padrao.svg',
          TweetMeta(liked: false, owner: true),
          null,
        ),
        TweetModel(
          '200528T2055370004',
          'penhas',
          551,
          '2020-05-28 20:55:37',
          0,
          0,
          false,
          'sleep 6',
          'https:\/\/elasv2-api.appcivico.com\/avatar\/padrao.svg',
          TweetMeta(liked: false, owner: true),
          null,
        ),
      ]);
      // act
      final result = TweetSessionModel.fromJson(jsonData);
      // assert
      expect(expectedSession, result);
    });

    test('should get lastReplay when it exists', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
          from: 'feed/retrieve_with_last_replay_response.json');
      final TweetSessionEntity expectedSession =
          TweetSessionModel(true, TweetSessionOrder.latestFirst, [
        TweetModel(
          '200528T2055370004',
          'penhas',
          551,
          '2020-05-28 20:55:37',
          1,
          1,
          false,
          'sleep 6',
          'https:\/\/elasv2-api.appcivico.com\/avatar\/padrao.svg',
          TweetMeta(liked: true, owner: true),
          TweetModel(
            '200603T1121340001',
            'penhas',
            551,
            '2020-06-03 11:21:34',
            0,
            0,
            false,
            'um breve comentario',
            'https:\/\/elasv2-api.appcivico.com\/avatar\/padrao.svg',
            TweetMeta(liked: false, owner: true),
            null,
          ),
        ),
      ]);
      // act
      final result = TweetSessionModel.fromJson(jsonData);
      // assert
      expect(expectedSession, result);
    });
  });
}
