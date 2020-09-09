import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  IUserProfileRepository sut;
  IApiProvider apiProvider;

  setUp(() {
    apiProvider = MockApiProvider();
    sut = UserProfileRepository(apiProvider: apiProvider);
  });

  void _setUpMockGet() {
    when(apiProvider.get(
      path: anyNamed('path'),
      parameters: anyNamed('parameters'),
    )).thenAnswer((_) async => Future.value(""));
  }

  group('UserProfileRepository', () {
    group('stealth mode', () {
      test('should hit endpoint /me/modo-camuflado-toggle', () async {
        // arrange
        _setUpMockGet();
        final endPoint = ['me', 'modo-camuflado-toggle'].join('/');
        final parameters = {'active': '1'};
        // act
        await sut.stealthMode(toggle: true);
        // assert
        verify(
          apiProvider.get(
            path: endPoint,
            parameters: parameters,
          ),
        );
      });
      test('should receive ValidField', () async {
        // arrange
        _setUpMockGet();
        final actual = right(ValidField());
        final toggle = true;
        // act
        final matcher = await sut.stealthMode(toggle: toggle);
        // assert
        expect(actual, matcher);
      });
    });

    group('anonymous mode', () {
      test('should hit endpoint /me/modo-anonimo-toggle', () async {
        // arrange
        _setUpMockGet();
        final endPoint = ['me', 'modo-anonimo-toggle'].join('/');
        final parameters = {'active': '1'};
        // act
        await sut.anonymousMode(toggle: true);
        // assert
        verify(
          apiProvider.get(
            path: endPoint,
            parameters: parameters,
          ),
        );
      });
      test('should receive ValidField', () async {
        // arrange
        _setUpMockGet();
        final actual = right(ValidField());
        final toggle = false;
        // act
        final matcher = await sut.anonymousMode(toggle: toggle);
        // assert
        expect(actual, matcher);
      });
    });
  });
}
