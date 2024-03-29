import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/extension/either.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';

import '../../../../../utils/json_util.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockTweetDataSource extends Mock implements ITweetDataSource {}

void main() {
  late ITweetRepository repository;
  late INetworkInfo networkInfo;
  late ITweetDataSource dataSource;

  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockTweetDataSource();

    repository =
        TweetRepository(dataSource: dataSource, networkInfo: networkInfo);
  });

  group(TweetRepository, () {
    late TweetSessionModel sessionModel;

    setUp(() async {
      final jsonSession =
          await JsonUtil.getJson(from: 'feed/retrieve_response.json');
      sessionModel = TweetSessionModel.fromJson(jsonSession);
      when(() => dataSource.fetch(option: any(named: 'option')))
          .thenAnswer((_) => Future.value(sessionModel));
    });
    group(
      'fetch()',
      () {
        test('retrieve tweets from a valid session', () async {
          // arrange
          final TweetSessionEntity expectedSession = sessionModel;
          // act
          final receivedSession =
              await repository.fetch(option: const TweetRequestOption());
          // assert
          expect(receivedSession.get(), expectedSession);
        });

        test('map error from data source', () async {
          // arrange
          const apiProviderException = ApiProviderException(
            bodyContent: {'error': 'expired_jwt'},
          );
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);
          when(() => dataSource.fetch(option: any(named: 'option')))
              .thenThrow(apiProviderException);
          // act
          final receivedSession =
              await repository.fetch(option: const TweetRequestOption());
          // assert
          expect(receivedSession, left(InternetConnectionFailure()));
        });
      },
    );
    group('create()', () {
      setUp(() async {
        final jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_create_response.json');
        when(() => dataSource.create(option: any(named: 'option')))
            .thenAnswer((_) => Future.value(TweetModel.fromJson(jsonData)));
      });
      test(
        'create tweet from a valid session',
        () async {
          // arrange
          final requestOption = TweetCreateRequestOption(message: 'Mensagem 1');
          final expected = right(
            TweetModel(
              id: '200608T1805540001',
              userName: 'maria',
              clientId: 424,
              createdAt: '2020-06-08 18:05:54',
              totalReply: 0,
              totalLikes: 0,
              anonymous: false,
              content: 'Mensagem 1',
              avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
            ),
          );
          // act
          final received = await repository.create(option: requestOption);
          // assert
          expect(received, expected);
        },
      );
      test('map erro from data source', () async {
        // arrange
        const apiProviderException = ApiProviderException(
          bodyContent: {'error': 'expired_jwt'},
        );
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        when(() => dataSource.create(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.create(
            option: TweetCreateRequestOption(message: 'Mensagem 1'));
        // assert
        expect(receivedSession, left(InternetConnectionFailure()));
      });
    });
    group('delete', () {
      setUp(() {
        when(() => dataSource.delete(option: any(named: 'option')))
            .thenAnswer((_) => Future.value(const ValidField()));
      });
      test(
        'delete tweet from a valid session',
        () async {
          // arrange
          final requestOption = TweetEngageRequestOption(
            tweetId: '200528T2055370004',
          );
          final expected = right(const ValidField());
          // act
          final received = await repository.delete(option: requestOption);
          // assert
          expect(received, expected);
        },
      );
      test('map error from data source', () async {
        // arrange
        const apiProviderException = ApiProviderException(
          bodyContent: {'error': 'expired_jwt'},
        );
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        when(() => dataSource.delete(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.delete(
            option: TweetEngageRequestOption(tweetId: '200528T2055370004'));
        // assert
        expect(receivedSession, left(InternetConnectionFailure()));
      });
    });
    group('like()', () {
      setUp(() async {
        final jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_like_response.json');
        final tweetModel = TweetModel.fromJson(jsonData['tweet']);

        when(() => dataSource.like(option: any(named: 'option')))
            .thenAnswer((_) => Future.value(tweetModel));
      });
      test(
        'favorite a valid tweet',
        () async {
          // arrange
          final requestOption =
              TweetEngageRequestOption(tweetId: '200520T0032210001');
          final expected = right(
            TweetModel(
              id: '200528T2055370004',
              userName: 'penhas',
              clientId: 551,
              createdAt: '2020-05-28 20:55:37',
              totalReply: 0,
              totalLikes: 1,
              anonymous: false,
              content: 'sleep 6',
              avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
              meta: const TweetMeta(liked: true, owner: true),
              lastReply: const [],
            ),
          );
          // act
          final received = await repository.like(option: requestOption);
          // assert
          expect(received, expected);
        },
      );
      test('map error from data source', () async {
        // arrange
        const apiProviderException = ApiProviderException(
          bodyContent: {'error': 'expired_jwt'},
        );
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        when(() => dataSource.like(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.like(
            option: TweetEngageRequestOption(tweetId: '200528T2055370004'));
        // assert
        expect(receivedSession, left(InternetConnectionFailure()));
      });
    });
    group('reply()', () {
      setUp(() async {
        final jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_reply_response.json');
        when(() => dataSource.reply(option: any(named: 'option')))
            .thenAnswer((_) => Future.value(TweetModel.fromJson(jsonData)));
      });

      test(
        'reply a valid tweet',
        () async {
          // arrange
          final requestOption = TweetEngageRequestOption(
            tweetId: '200528T2055370004',
            message: 'um breve comentario',
          );
          final expected = right(
            TweetModel(
              id: '200608T1809090001',
              userName: 'rosa',
              clientId: 551,
              createdAt: '2020-06-08 18:09:09',
              totalReply: 0,
              totalLikes: 0,
              anonymous: false,
              content: 'um breve comentario',
              avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
              meta: const TweetMeta(liked: false, owner: true),
              lastReply: const [],
            ),
          );
          // act
          final received = await repository.reply(option: requestOption);
          // assert
          expect(received, expected);
        },
      );

      test('map error from data source', () async {
        // arrange
        const apiProviderException = ApiProviderException(
          bodyContent: {'error': 'expired_jwt'},
        );
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        when(() => dataSource.reply(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.reply(
            option: TweetEngageRequestOption(
          tweetId: '200528T2055370004',
        ));
        // assert
        expect(receivedSession, left(InternetConnectionFailure()));
      });
    });
    group('current()', () {
      setUp(() async {
        final jsonData =
            await JsonUtil.getJson(from: 'feed/tweet_current_response.json');
        when(() => dataSource.current(option: any(named: 'option'))).thenAnswer(
          (_) => Future.value(TweetSessionModel.fromJson(jsonData)),
        );
      });

      test(
        'get a current version of a tweet',
        () async {
          // arrange
          final requestOption = TweetEngageRequestOption(
            tweetId: '200528T2055370004',
          );
          final expected = right(
            TweetSessionModel(
              TweetSessionOrder.latestFirst,
              null,
              [
                TweetModel(
                  id: '200608T1545460001',
                  userName: 'maria',
                  clientId: 551,
                  createdAt: '2020-06-08 15:45:46',
                  totalReply: 0,
                  totalLikes: 0,
                  anonymous: false,
                  content: 'Comentário 7',
                  avatar: 'https://elasv2-api.appcivico.com/avatar/padrao.svg',
                  meta: const TweetMeta(
                      liked: false, owner: true, canReply: false),
                  lastReply: const [],
                )
              ],
              null,
              hasMore: false,
            ),
          );
          // act
          final received = await repository.current(option: requestOption);
          // assert
          expect(received, expected);
        },
      );

      test('map error from data source', () async {
        // arrange
        const apiProviderException = ApiProviderException(
          bodyContent: {'error': 'expired_jwt'},
        );
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        when(() => dataSource.current(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.current(
            option: TweetEngageRequestOption(tweetId: '200528T2055370004'));
        // assert
        expect(receivedSession, left(InternetConnectionFailure()));
      });
    });

    group(
      'report()',
      () {
        setUp(() {
          when(() => dataSource.report(option: any(named: 'option')))
              .thenAnswer((_) => Future.value(const ValidField()));
        });
        test('report a valid tweet', () async {
          // arrange
          final requestOption = TweetEngageRequestOption(
            tweetId: '200528T2055370004',
            message: 'informação agressiva',
          );
          final expected = right(const ValidField());
          // act
          final received = await repository.report(option: requestOption);
          // assert
          expect(received, expected);
        });

        test('map error from data source', () async {
          // arrange
          const apiProviderException = ApiProviderException(
            bodyContent: {'error': 'expired_jwt'},
          );
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);
          when(() => dataSource.report(option: any(named: 'option')))
              .thenThrow(apiProviderException);
          // act
          final receivedSession = await repository.report(
              option: TweetEngageRequestOption(tweetId: '200528T2055370004'));
          // assert
          expect(receivedSession, left(InternetConnectionFailure()));
        });
      },
    );

    group('mapping error', () {
      late TweetEngageRequestOption requestOption;
      setUp(() {
        requestOption = TweetEngageRequestOption(tweetId: '200528T2055370004');
      });

      test(
          'return an InternetConnectionFailure when the network is disconnected',
          () async {
        // arrange
        const apiProviderException = ApiProviderException(
          bodyContent: {'error': 'expired_jwt'},
        );
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        when(() => dataSource.report(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.report(option: requestOption);
        // assert
        expect(receivedSession, left(InternetConnectionFailure()));
      });

      test('return a ServerFailure when the session is invalid', () async {
        // arrange
        const apiProviderException = ApiProviderException(
          bodyContent: {'error': 'expired_jwt'},
        );
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => dataSource.report(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.report(option: requestOption);
        // assert
        expect(receivedSession, left(ServerSideSessionFailed()));
      });

      test(
          'return a ServerSideFormFieldValidationFailure when got server error',
          () async {
        // arrange
        const apiProviderException = ApiProviderException(
          bodyContent: {
            'error': 'invalid_form',
            'field': 'name',
            'reason': 'invalid',
            'message': 'Nome inválido',
          },
        );
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => dataSource.report(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.report(option: requestOption);
        // assert
        expect(
          receivedSession,
          left(
            ServerSideFormFieldValidationFailure(
              error: 'invalid_form',
              field: 'name',
              reason: 'invalid',
              message: 'Nome inválido',
            ),
          ),
        );
      });

      test('return a ServerSideSessionFailed when got server error', () async {
        // arrange
        final apiProviderException = ApiProviderSessionError();
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => dataSource.report(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.report(option: requestOption);
        // assert
        expect(receivedSession, left(ServerSideSessionFailed()));
      });

      test('return a ServerFailure for a not mapped error', () async {
        // arrange
        final apiProviderException = NetworkServerException();
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => dataSource.report(option: any(named: 'option')))
            .thenThrow(apiProviderException);
        // act
        final receivedSession = await repository.report(option: requestOption);
        // assert
        expect(receivedSession, left(ServerFailure()));
      });
    });
  });
}
