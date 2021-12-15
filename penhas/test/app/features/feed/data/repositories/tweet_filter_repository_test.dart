import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/feed/data/models/tweet_filter_session_model.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_filter_preference_repository.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late MockINetworkInfo networkInfo = MockINetworkInfo();
  late MockITweetFilterPreferenceDataSource dataSource =
      MockITweetFilterPreferenceDataSource();
  late ITweetFilterPreferenceRepository sut;
  Map<String, dynamic> jsonSession;

  setUp(() {
    sut = TweetFilterPreferenceRepository(
      networkInfo: networkInfo,
      dataSource: dataSource,
    );
  });

  group('TweetFilterPreferenceRepository', () {
    TweetFilterSessionModel? sessionModel;
    setUp(() async {
      jsonSession =
          await JsonUtil.getJson(from: 'feed/retrieve_fiters_tags.json');
      sessionModel = TweetFilterSessionModel.fromJson(jsonSession);
      when(dataSource.fetch()).thenAnswer((_) => Future.value(sessionModel));
    });
    group('fetch()', () {
      test('should retrieve tweets from a valid session', () async {
        // arrange
        final TweetFilterSessionEntity? expectedSession = sessionModel;
        // act
        final receivedSession = await sut.retreive();
        // assert
        expect(receivedSession, right(expectedSession));
      });
    });
  });
}
