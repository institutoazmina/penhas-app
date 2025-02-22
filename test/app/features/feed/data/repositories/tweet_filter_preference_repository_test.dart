import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/feed/data/models/tweet_filter_session_model.dart';
import 'package:penhas/app/features/feed/data/repositories/tweet_filter_preference_repository.dart';

import '../../../../../utils/api_provider_mock.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late ITweetFilterPreferenceRepository sut;

  final jsonFile = 'feed/retrieve_filters_tags.json';

  setUp(() {
    ApiProviderMock.init();

    sut = TweetFilterPreferenceRepository(
      apiProvider: ApiProviderMock.apiProvider,
    );
  });

  void _setUpMockHttpClientResponse(String body, {int? statusCode}) {
    ApiProviderMock.apiClientResponse(body, statusCode ?? 200);
  }

  group(TweetFilterPreferenceRepository, () {
    test(
      'retrieve filter preferences from a valid session',
      () async {
        // arrange
        final jsonSession = await JsonUtil.getJson(from: jsonFile);
        final sessionModel = TweetFilterSessionModel.fromJson(jsonSession);
        final jsonString = JsonUtil.getStringSync(from: jsonFile);
        _setUpMockHttpClientResponse(jsonString);
        // act
        final received = await sut.retrieve();
        // assert
        final request = verify(
          () => ApiProviderMock.httpClient.send(captureAny()),
        ).captured.single;

        expect(request.url.path, '/filter-tags');
        expect(request.method, 'GET');
        expect(request.headers['Content-Type'],
            'application/x-www-form-urlencoded; charset=utf-8');

        expect(received.fold(id, id), sessionModel);
      },
    );
  });
}
