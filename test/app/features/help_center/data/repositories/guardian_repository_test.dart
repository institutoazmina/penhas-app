import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/help_center/data/models/guardian_session_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';

import '../../../../../utils/api_provider_mock.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late IGuardianRepository sut;

  setUp(() {
    ApiProviderMock.init();

    sut = GuardianRepository(apiProvider: ApiProviderMock.apiProvider);
  });

  void _setUpMockHttpClientResponse(String body, {int? statusCode}) {
    ApiProviderMock.apiClientResponse(body, statusCode ?? 200);
  }

  group(
    GuardianRepository,
    () {
      group('fetch()', () {
        test(
          'return empty guardian list when there are no guardians',
          () async {
            // arrange
            final jsonFile = 'help_center/guardian_empty_list.json';
            _setUpMockHttpClientResponse(
                JsonUtil.getStringSync(from: jsonFile));
            final jsonSession = await JsonUtil.getJson(from: jsonFile);
            final emptySession = GuardianSessionModel.fromJson(jsonSession);
            // act
            final actual = await sut.fetch();
            // assert
            expect(actual.fold(id, id), emptySession);
          },
        );
        test(
          'return a list of guardians',
          () async {
            // arrange
            final jsonFile = 'help_center/guardian_list.json';
            _setUpMockHttpClientResponse(
                JsonUtil.getStringSync(from: jsonFile));
            final jsonSession = await JsonUtil.getJson(from: jsonFile);
            final sessionModel = GuardianSessionModel.fromJson(jsonSession);
            // act
            final actual = await sut.fetch();
            // assert
            expect(actual.fold(id, id), sessionModel);
          },
        );
      });
      group('create()', () {
        test(
          'return success alert when creating valid guardian',
          () async {
            // arrange
            final jsonFile = 'help_center/guardian_create_successful.json';
            _setUpMockHttpClientResponse(
                JsonUtil.getStringSync(from: jsonFile));
            final jsonSession = await JsonUtil.getJson(from: jsonFile);
            final guardian = GuardianContactEntity.createRequest(
              name: 'Maria',
              mobile: '1191910101',
            );
            final response = AlertModel.fromJson(jsonSession);
            // act
            final actual = await sut.create(guardian);
            // assert
            expect(actual.fold(id, id), response);
          },
        );

        test(
          'return error message when creating guardian with invalid phone number',
          () async {
            // arrange
            final jsonFile = 'help_center/guardian_bad_celular_number.json';
            _setUpMockHttpClientResponse(
                JsonUtil.getStringSync(from: jsonFile));
            final jsonSession = await JsonUtil.getJson(from: jsonFile);
            final response = AlertModel.fromJson(jsonSession);
            final guardian = GuardianContactEntity.createRequest(
              name: 'Maria',
              mobile: '91910101',
            );
            // act
            final actual = await sut.create(guardian);
            // assert
            expect(actual.fold(id, id), response);
          },
        );
      });
      group('update()', () {
        test(
          'return success message when updating guardian name',
          () async {
            // arrange
            final jsonFile = 'help_center/guardian_update_name.json';
            _setUpMockHttpClientResponse(
                JsonUtil.getStringSync(from: jsonFile));
            final jsonSession = await JsonUtil.getJson(from: jsonFile);
            final response = ValidField.fromJson(jsonSession);
            const guardian = GuardianContactEntity(
              id: 1,
              mobile: '(11) 91910101',
              name: 'Renato Lindão',
              status: 'pending',
            );
            // act
            final actual = await sut.update(guardian);
            // assert
            expect(actual.fold(id, id), response);
          },
        );
        test(
          'return success message when deleting guardian',
          () async {
            // arrange
            const guardian = GuardianContactEntity(
              id: 1,
              mobile: '(11) 91910101',
              name: 'Maria (PenhaS)',
              status: 'pending',
            );
            _setUpMockHttpClientResponse('{}');
            // act
            final actual = await sut.delete(guardian);
            // assert
            expect(actual.fold(id, id), const ValidField());
          },
        );
      });
      group('alert()', () {
        test(
          'return success message when sending alert to guardian',
          () async {
            // arrange
            final jsonString =
                '''{"message": "Alerta disparado com sucesso para 1 guardião.","title": "Alerta enviado!"}''';
            _setUpMockHttpClientResponse(jsonString);
            const location = UserLocationEntity(latitude: 1.0, longitude: -1.0);
            final expected = AlertModel.fromJson(jsonDecode(jsonString));
            // act
            final actual = await sut.alert(location);
            // assert
            expect(actual.fold(id, id), expected);
          },
        );
      });
    },
  );
}
