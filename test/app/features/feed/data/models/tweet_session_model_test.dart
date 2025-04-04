import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  TweetSessionModel tweetSessionMondel;
  setUp(() {});

  group('TweetSessionModel', () {
    test('tweets should be a subclass of TweetSessionEntity', () async {
      // arrange
      tweetSessionMondel = const TweetSessionModel(
        TweetSessionOrder.latestFirst,
        null,
        [],
        null,
        hasMore: false,
      );
      // assert
      expect(tweetSessionMondel, isA<TweetSessionEntity>());
    });

    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'feed/retrieve_response.json');
      final TweetSessionModel expectedSession = TweetSessionModel(
        TweetSessionOrder.latestFirst,
        null,
        [
          TweetModel(
            id: '200528T2055380001',
            userName: 'penhas',
            clientId: 551,
            createdAt: '2020-05-28 20:55:38',
            totalReply: 0,
            totalLikes: 0,
            anonymous: false,
            content: 'sleep 7',
            avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
            meta: const TweetMeta(liked: false, owner: true),
            lastReply: const [],
            badges: [],
          ),
          TweetRelatedNewsModel(
            header: 'google',
            news: [
              TweetNewsModel(
                title: 'Titulo muito grande',
                newsUri: 'https://site.com/news-redirect/?uid=551',
              )
            ],
          ),
          TweetModel(
            id: '200528T2055370004',
            userName: 'penhas',
            clientId: 551,
            createdAt: '2020-05-28 20:55:37',
            totalReply: 0,
            totalLikes: 0,
            anonymous: false,
            content: 'sleep 6',
            avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
            meta: const TweetMeta(liked: false, owner: true, canReply: false),
            lastReply: const [],
            badges: [],
          ),
          TweetNewsModel(
            date: '18/06/2020',
            newsUri: 'https://site.com/news-redirect/?uid=552',
            imageUri: 'https://s2.glbimg.com/n.jpg',
            source: 'Google News',
            title: 'Title News 1',
          ),
          TweetNewsGroupModel(
            header: 'Relacionamento API Random',
            news: [
              TweetNewsModel(
                date: '18/06/2020',
                newsUri: 'https://site.com/news-redirect/?uid=600',
                imageUri: 'https://s2.glbimg.com/n.jpg',
                source: 'Google News',
                title: 'Title News Group - 0',
              ),
              TweetNewsModel(
                date: '18/06/2020',
                newsUri: 'https://site.com/news-redirect/?uid=601',
                imageUri: 'https://s2.glbimg.com/n.jpg',
                source: 'Google News',
                title: 'Title News Group - 1',
              ),
              TweetNewsModel(
                date: '18/06/2020',
                newsUri: 'https://site.com/news-redirect/?uid=602',
                imageUri: 'https://s2.glbimg.com/n.jpg',
                source: 'Google News',
                title: 'Title News Group - 2',
              ),
            ],
          )
        ],
        '_next_page_token_',
        hasMore: true,
      );
      // act
      final result = TweetSessionModel.fromJson(jsonData);
      // assert
      expect(result, expectedSession);
    });

    test('should get lastReplay when it exists', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
        from: 'feed/retrieve_with_last_replay_response.json',
      );
      final TweetSessionEntity expectedSession = TweetSessionModel(
        TweetSessionOrder.latestFirst,
        null,
        [
          TweetModel(
            id: '200528T2055370004',
            userName: 'penhas',
            clientId: 551,
            createdAt: '2020-05-28 20:55:37',
            totalReply: 1,
            totalLikes: 1,
            anonymous: false,
            content: 'sleep 6',
            avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
            meta: const TweetMeta(liked: true, owner: true),
            lastReply: [
              TweetModel(
                id: '200603T1121340001',
                userName: 'penhas',
                clientId: 551,
                createdAt: '2020-06-03 11:21:34',
                totalReply: 0,
                totalLikes: 0,
                anonymous: false,
                content: 'um breve comentario',
                avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
                meta: const TweetMeta(
                  liked: false,
                  owner: true,
                  canReply: false,
                ),
                parentId: '200528T2055370004',
                lastReply: const [],
                badges: [],
              )
            ],
            badges: [],
          ),
        ],
        null,
        hasMore: true,
      );
      // act
      final result = TweetSessionModel.fromJson(jsonData);
      // assert
      expect(result, expectedSession);
    });
  });
}
