import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_session_model.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

import '../../../../../utils/json_util.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockTweetDataSource extends Mock implements ITweetDataSource {}

void main() {
  ITweetRepository repository;
  TweetSessionModel sessionModel;
  INetworkInfo networkInfo;
  ITweetDataSource dataSource;
  Map<String, Object> jsonSession;

  setUp(() async {
    networkInfo = MockNetworkInfo();
    dataSource = MockTweetDataSource();
    repository =
        TweetRepository(dataSource: dataSource, networkInfo: networkInfo);
    jsonSession = await JsonUtil.getJson(from: 'feed/retrieve_response.json');
    sessionModel = TweetSessionModel.fromJson(jsonSession);
    when(dataSource.retrieve()).thenAnswer((_) => Future.value(sessionModel));
  });

  group('TweetRepository', () {
    test('should retrieve tweets from a valid session', () async {
      // arrange
      final TweetSessionEntity expectedSession = sessionModel;
      // act
      final receivedSession = await repository.retrieve();
      // assert
      expect(receivedSession, right(expectedSession));
    });

    test('should create tweet from a valid session', () async {
      // arrange
      // act
      // assert
    });

    test('should favorite a valid tweet', () async {
      // arrange
      // act
      // assert
    });

    test('should reply a valid tweet', () async {
      // arrange
      // act
      // assert
    });

    test('should report a valid tweet', () async {
      // arrange
      // act
      // assert
    });
  });
}
