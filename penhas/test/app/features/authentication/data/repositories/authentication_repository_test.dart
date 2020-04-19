import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/i_network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

import '../../../../../utils/json_util.dart';

class MockAuthenticationDataSource extends Mock
    implements AuthenticationDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  AuthenticationRepository repository;
  MockAuthenticationDataSource dataSource;
  MockNetworkInfo networkInfo;

  setUp(() async {
    dataSource = MockAuthenticationDataSource();
    networkInfo = MockNetworkInfo();
    repository = AuthenticationRepository(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
  });

  group('SigIn', () {
    Map<String, dynamic> loginSuccessJson;
    SessionModel sessionModel;
    SessionEntity sessionEntity;
    EmailAddress email;
    Password password;

    setUp(() async {
      loginSuccessJson =
          await JsonUtil.getJson(from: 'authentication/login_success.json');
      sessionModel = SessionModel.fromJson(loginSuccessJson);
      sessionEntity = sessionModel;
      email = EmailAddress('test@g.com');
      password = Password('_myStrongP4ss@rd');
    });

    group('device is online', () {
      setUp(() async {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return valid SessionEntity for valid user/password',
          () async {
        // arrange
        when(
          dataSource.signInWithEmailAndPassword(
            emailAddress: anyNamed('emailAddress'),
            password: anyNamed('password'),
          ),
        ).thenAnswer((_) async => sessionModel);
        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
        verify(dataSource.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        ));

        expect(result, right(sessionEntity));
      });
      test(
          'should return server failure when the call to remote server is unsuccessfull',
          () async {
        // arrange
        when(
          dataSource.signInWithEmailAndPassword(
            emailAddress: anyNamed('emailAddress'),
            password: anyNamed('password'),
          ),
        ).thenThrow(ApiProviderException());
        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
        verify(dataSource.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        ));
        expect(result, left(ServerFailure()));
      });

      test('should return login failure for unsuccessfull user validation',
          () async {
        // arrange
        final bodyContent =
            await JsonUtil.getJson(from: 'authentication/login_failure.json');

        when(
          dataSource.signInWithEmailAndPassword(
            emailAddress: anyNamed('emailAddress'),
            password: anyNamed('password'),
          ),
        ).thenThrow(ApiProviderException(bodyContent: bodyContent));
        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
        verify(dataSource.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        ));
        expect(result, left(UserAuthenticationFailure()));
      });
    });

    group('device is offline', () {
      setUp(() async {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return InternetConnectionFailure', () async {
        when(
          dataSource.signInWithEmailAndPassword(
            emailAddress: anyNamed('emailAddress'),
            password: anyNamed('password'),
          ),
        ).thenThrow(ApiProviderException());
        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
        verify(dataSource.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        ));
        verify(networkInfo.isConnected);
        expect(result, left(InternetConnectionFailure()));
      });
    });
  });
}
