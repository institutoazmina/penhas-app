import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/feed/data/datasources/tweet_filter_preference_data_source.dart';
import 'package:penhas/app/features/feed/data/models/tweet_filter_session_model.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_filter_preference_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

import '../../../../../utils/json_util.dart';

class MockTweetFilterRepository extends Mock
    implements ITweetFilterPreferenceRepository {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockTweetFilterPreferenceDataSource extends Mock
    implements ITweetFilterPreferenceDataSource {}

void main() {
  INetworkInfo networkInfo;
  ITweetFilterPreferenceRepository sut;
  ITweetFilterPreferenceDataSource dataSource;
  Map<String, Object> jsonSession;

  setUp(() async {
    networkInfo = MockNetworkInfo();
    dataSource = MockTweetFilterPreferenceDataSource();
    sut = TweetFilterPreferenceRepository(
      networkInfo: networkInfo,
      dataSource: dataSource,
    );
  });

  group('TweetFilterPreferenceRepository', () {
    TweetFilterSessionModel sessionModel;
    setUp(() async {
      jsonSession =
          await JsonUtil.getJson(from: 'feed/retrieve_fiters_tags.json');
      sessionModel = TweetFilterSessionModel.fromJson(jsonSession);
      when(dataSource.fetch()).thenAnswer((_) => Future.value(sessionModel));
    });
    group('fetch()', () {
      test('should retrieve tweets from a valid session', () async {
        // arrange
        final TweetFilterSessionEntity expectedSession = sessionModel;
        // act
        final receivedSession = await sut.retreive();
        // assert
        expect(receivedSession, right(expectedSession));
      });
    });
  });
}
