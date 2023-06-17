import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/main_menu/data/model/account_preference_model.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';

class MockApiProvider extends Mock implements IApiProvider {}

class MockApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late IUserProfileRepository sut;
  late IApiProvider apiProvider;
  late IApiServerConfigure serverConfiguration;

  setUpAll(() {
    apiProvider = MockApiProvider();
    serverConfiguration = MockApiServerConfigure();
    sut = UserProfileRepository(
      apiProvider: apiProvider,
      serverConfiguration: serverConfiguration,
    );
  });

  void _setUpMockPost() {
    when(
      () => apiProvider.post(
        path: any(named: 'path'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async => Future.value(''));
  }

  void _setUpMockPostException() {
    when(
      () => apiProvider.post(
        path: any(named: 'path'),
        parameters: any(named: 'parameters'),
      ),
    ).thenThrow(Exception());
  }

  group(UserProfileRepository, () {
    group('stealth mode', () {
      test(
        'hit endpoint /me/modo-camuflado-toggle',
        () async {
          // arrange
          _setUpMockPost();
          final endPoint = '/me/modo-camuflado-toggle';
          final parameters = {'active': '1'};
          // act
          await sut.stealthMode(toggle: true);
          // assert
          verify(
            () => apiProvider.post(
              path: endPoint,
              parameters: parameters,
            ),
          ).called(1);
        },
      );
      test(
        'receive ValidField',
        () async {
          // arrange
          _setUpMockPost();
          final expected = right(const ValidField());
          const toggle = true;
          // act
          final actual = await sut.stealthMode(toggle: toggle);
          // assert
          expect(actual, expected);
        },
      );

      test('return Failure when encounters an error', () async {
        // arrange
        _setUpMockPostException();
        // act
        final result = await sut.stealthMode(toggle: true);
        // assert
        expect(result, equals(left(ServerFailure())));
      });
    });
    group('anonymous mode', () {
      test('hit endpoint /me/modo-anonimo-toggle', () async {
        // arrange
        _setUpMockPost();
        final endPoint = '/me/modo-anonimo-toggle';
        final parameters = {'active': '1'};
        // act
        await sut.anonymousMode(toggle: true);
        // assert
        verify(
          () => apiProvider.post(
            path: endPoint,
            parameters: parameters,
          ),
        ).called(1);
      });
      test(
        'receive ValidField',
        () async {
          // arrange
          _setUpMockPost();
          final expected = right(const ValidField());
          const toggle = false;
          // act
          final actual = await sut.anonymousMode(toggle: toggle);
          // assert
          expect(actual, expected);
        },
      );
      test('return Failure when encounters an error', () async {
        // arrange
        _setUpMockPostException();
        // act
        final result = await sut.anonymousMode(toggle: true);
        // assert
        expect(result, equals(left(ServerFailure())));
      });
    });

    group('delete method', () {
      test('hit endpoint /me', () async {
        // arrange
        const endPoint = '/me';
        when(() => apiProvider.delete(
                path: any(named: 'path'), parameters: any(named: 'parameters')))
            .thenAnswer((_) async => Future.value(''));
        when(() => serverConfiguration.userAgent).thenAnswer((_) async => 'v1');
        // act
        await sut.delete(password: '123456');
        // assert
        verify(
          () => apiProvider.delete(
              path: endPoint,
              parameters: {'senha_atual': '123456', 'app_version': 'v1'}),
        ).called(1);
      });
      test(
        'receive ValidField',
        () async {
          // arrange
          final expected = right(const ValidField());
          when(() => apiProvider.delete(
                  path: any(named: 'path'),
                  parameters: any(named: 'parameters')))
              .thenAnswer((_) async => Future.value(''));
          when(() => serverConfiguration.userAgent)
              .thenAnswer((_) async => 'v1');
          // act
          final actual = await sut.delete(password: '123456');
          // assert
          expect(actual, expected);
        },
      );
      test('return Failure when encounters an error', () async {
        // arrange
        when(() => apiProvider.delete(
            path: any(named: 'path'),
            parameters: any(named: 'parameters'))).thenThrow(Exception());
        when(() => serverConfiguration.userAgent).thenAnswer((_) async => 'v1');
        // act
        final result = await sut.delete(password: '123456');
        // assert
        expect(result, equals(left(ServerFailure())));
      });
    });
    group('deleteNotice method', () {
      test('hit endpoint /me/delete-text', () async {
        // arrange
        final endPoint = '/me/delete-text';
        when(() => apiProvider.get(path: any(named: 'path')))
            .thenAnswer((_) async => Future.value(''));
        // act
        await sut.deleteNotice();
        // assert
        verify(
          () => apiProvider.get(path: endPoint),
        ).called(1);
      });
      test(
        'receive ValidField',
        () async {
          // arrange
          final expected = right(const ValidField());
          when(() => apiProvider.get(path: any(named: 'path')))
              .thenAnswer((_) async => Future.value(''));
          // act
          final actual = await sut.deleteNotice();
          // assert
          expect(actual, expected);
        },
      );
      test('return Failure when encounters an error', () async {
        // arrange
        when(() => apiProvider.get(path: any(named: 'path')))
            .thenThrow(Exception());
        // act
        final result = await sut.deleteNotice();
        // assert
        expect(result, equals(left(ServerFailure())));
      });
    });
    group('reactivate method', () {
      test('hit endpoint /reactivate', () async {
        // arrange
        const endPoint = '/reactivate';
        const parameters = {'app_version': 'v1', 'api_key': 'abc'};

        when(() => apiProvider.post(
                path: any(named: 'path'), parameters: any(named: 'parameters')))
            .thenAnswer((_) async => Future.value(''));
        when(() => serverConfiguration.userAgent).thenAnswer((_) async => 'v1');
        // act
        await sut.reactivate(token: 'abc');
        // assert
        verify(() => apiProvider.post(path: endPoint, parameters: parameters))
            .called(1);
      });
      test(
        'receive ValidField',
        () async {
          // arrange
          final expected = right(const ValidField(message: 'abc'));
          when(() => apiProvider.post(
                  path: any(named: 'path'),
                  parameters: any(named: 'parameters')))
              .thenAnswer((_) async => Future.value(''));
          when(() => serverConfiguration.userAgent)
              .thenAnswer((_) async => 'v1');
          // act
          final actual = await sut.reactivate(token: 'abc');
          // assert
          expect(actual, expected);
        },
      );
      test('return Failure when encounters an error', () async {
        // arrange
        when(() => apiProvider.post(
            path: any(named: 'path'),
            parameters: any(named: 'parameters'))).thenThrow(Exception());
        when(() => serverConfiguration.userAgent).thenAnswer((_) async => 'v1');
        // act
        final result = await sut.reactivate(token: 'abc');
        // assert
        expect(result, equals(left(ServerFailure())));
      });
    });

    group('preferences method', () {
      late String endPoint;
      late String jsonData;

      setUp(() {
        endPoint = '/me/preferences';
        jsonData =
            '{"preferences": [{"key": "testKey","label": "testLabel","value": "1"}]}';
      });
      test('hit endpoint /me/preferences', () async {
        // arrange
        when(() => apiProvider.get(path: any(named: 'path')))
            .thenAnswer((_) async => jsonData);
        // act
        await sut.preferences();
        // assert
        verify(() => apiProvider.get(path: endPoint)).called(1);
      });
      test('receive AccountPreferenceSessionModel', () async {
        // arrange
        final expected = right(
          const AccountPreferenceSessionModel(preferences: [
            AccountPreferenceModel(
                key: 'testKey', value: true, label: 'testLabel')
          ]),
        );
        when(() => apiProvider.get(path: any(named: 'path')))
            .thenAnswer((_) async => jsonData);
        // act
        final actual = await sut.preferences();
        // assert
        expect(actual, expected);
      });
      test('return Failure when encounters an error', () async {
        // arrange
        when(() => apiProvider.get(path: any(named: 'path')))
            .thenThrow(Exception());
        // act
        final result = await sut.preferences();
        // assert
        expect(result, equals(left(ServerFailure())));
      });
    });
    group('updatePreferences method', () {
      late String endPoint;
      late String jsonData;

      setUp(() {
        endPoint = '/me/preferences';
        jsonData =
            '{"preferences": [{"key": "testKey","label": "testLabel","value": "1"}]}';
      });
      test('hit endpoint /me/preferences', () async {
        // arrange
        when(() => apiProvider.post(
                path: any(named: 'path'), parameters: any(named: 'parameters')))
            .thenAnswer((_) async => jsonData);
        // act
        await sut.updatePreferences(key: 'foo', status: true);
        // assert
        verify(
            () => apiProvider.post(path: endPoint, parameters: {'foo': '1'}));
      });
      test('receive AccountPreferenceModel', () async {
        // arrange
        final expected = right(
          const AccountPreferenceSessionModel(preferences: [
            AccountPreferenceModel(
                key: 'testKey', value: true, label: 'testLabel')
          ]),
        );
        when(() => apiProvider.post(
                path: any(named: 'path'), parameters: any(named: 'parameters')))
            .thenAnswer((_) async => jsonData);
        // act
        final actual = await sut.updatePreferences(key: 'foo', status: false);
        // assert
        expect(actual, expected);
      });
      test('return Failure when encounters an error', () async {
        // arrange
        when(() => apiProvider.post(
            path: any(named: 'path'),
            parameters: any(named: 'parameters'))).thenThrow(Exception());
        // act
        final actual = await sut.updatePreferences(key: 'foo', status: false);
        // assert
        expect(actual, equals(left(ServerFailure())));
      });
    });
  });
}
