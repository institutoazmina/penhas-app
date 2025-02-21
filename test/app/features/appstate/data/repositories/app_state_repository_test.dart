import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/data/repositories/app_state_repository.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';

import '../../../../../utils/api_provider_mock.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late IAppStateRepository sut;
  late Map<String, dynamic> jsonData;

  const jsonFile = 'profile/about_with_quiz_session.json';

  setUpAll(() {
    registerFallbackValue(UpdateUserProfileEntity());
  });

  setUp(() async {
    ApiProviderMock.init();

    sut = AppStateRepository(apiProvider: ApiProviderMock.apiProvider);
    jsonData = await JsonUtil.getJson(from: jsonFile);
  });

  void _setUpMockHttpClientResponse(String body, {int? statusCode}) {
    ApiProviderMock.apiClientResponse(body, statusCode ?? 200);
  }

  group(AppStateRepository, () {
    group('check()', () {
      test('return valid AppStateEntity when session is valid', () async {
        // arrange
        _setUpMockHttpClientResponse(JsonUtil.getStringSync(from: jsonFile));
        final expectedEntity = AppStateModel.fromJson(jsonData);
        // act
        final received = await sut.check();
        // assert
        expect(received.fold(id, id), expectedEntity);
      });
    });

    group('update()', () {
      test('return valid AppStateEntity when updating user profile', () async {
        // arrange
        _setUpMockHttpClientResponse(JsonUtil.getStringSync(from: jsonFile));
        final expectedModel = AppStateModel.fromJson(jsonData);
        final profile = UpdateUserProfileEntity();
        // act
        final received = await sut.update(profile);
        // assert
        expect(received, right(expectedModel));
      });
    });
  });
}
