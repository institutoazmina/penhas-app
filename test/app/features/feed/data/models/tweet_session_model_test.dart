import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_media_entity.dart';
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

    test('should parse media with sd and hd urls', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
        from: 'feed/retrieve_with_media_response.json',
      );

      // act
      final result = TweetSessionModel.fromJson(jsonData);
      final tweet = result.tweets.single as TweetModel;

      // assert
      expect(
        tweet.media,
        [
          const TweetMediaEntity(
            sd: 'https://api-hmg.penhas.com.br/media-download/?m=1122575b-5315-450e-8067-905a08acf21e&q=sd&h=77ac8a567bbd',
            hd: 'https://api-hmg.penhas.com.br/media-download/?m=1122575b-5315-450e-8067-905a08acf21e&q=hd&h=a639dc67c021',
          ),
        ],
      );
    });

    test('should preserve media when copying a tweet', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
        from: 'feed/retrieve_with_media_response.json',
      );
      final tweet =
          TweetSessionModel.fromJson(jsonData).tweets.single as TweetModel;

      // act
      final result = tweet.copyWith(totalLikes: 1);

      // assert
      expect(result.media, tweet.media);
      expect(result.totalLikes, 1);
    });

    test('should ignore invalid media entries', () {
      // arrange
      final jsonData = {
        'id': '261028T0307280000',
        'name': 'Admin PenhaS',
        'cliente_id': 0,
        'created_at': '2026-10-28 03:07:28',
        'qtde_comentarios': 0,
        'qtde_likes': 0,
        'anonimo': 0,
        'content': '',
        'icon': '',
        'media': [
          {'sd': null, 'hd': null},
          {'sd': '', 'hd': ''},
          {'sd': 'https://api.test/sd', 'hd': 'https://api.test/hd'},
        ],
        'meta': {'liked': 0, 'owner': 0, 'can_reply': 1},
        'last_reply': null,
        'badges': [],
      };

      // act
      final result = TweetModel.fromJson(jsonData);

      // assert
      expect(
        result.media,
        const [
          TweetMediaEntity(
            sd: 'https://api.test/sd',
            hd: 'https://api.test/hd',
          ),
        ],
      );
    });
  });
}
