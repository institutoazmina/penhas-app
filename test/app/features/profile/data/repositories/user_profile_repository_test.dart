import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
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

  group(UserProfileRepository, () {
    group('stealth mode', () {
      test(
        'hit endpoint /me/modo-camuflado-toggle',
        () async {
          // arrange
          _setUpMockPost();
          final endPoint = ['me', 'modo-camuflado-toggle'].join('/');
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
          final actual = right(const ValidField());
          const toggle = true;
          // act
          final expected = await sut.stealthMode(toggle: toggle);
          // assert
          expect(actual, expected);
        },
      );
    });

    group('anonymous mode', () {
      test('hit endpoint /me/modo-anonimo-toggle', () async {
        // arrange
        _setUpMockPost();
        final endPoint = ['me', 'modo-anonimo-toggle'].join('/');
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
          final actual = right(const ValidField());
          const toggle = false;
          // act
          final matcher = await sut.anonymousMode(toggle: toggle);
          // assert
          expect(actual, matcher);
        },
      );
    });
  });
}
