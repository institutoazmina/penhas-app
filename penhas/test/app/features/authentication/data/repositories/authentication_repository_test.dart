import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
<<<<<<< HEAD
  late final MockAuthenticationDataSource dataSource =
      MockAuthenticationDataSource();
  late final MockIAppConfiguration appConfiguration = MockIAppConfiguration();
  late final MockINetworkInfo networkInfo = MockINetworkInfo();
  late AuthenticationRepository repository;
=======
  late AuthenticationRepository repository;
  MockAuthenticationDataSource? dataSource;
  MockAppConfiguration? appConfiguration;
  MockNetworkInfo? networkInfo;
>>>>>>> Migrate code to nullsafety

  setUp(() {
    repository = AuthenticationRepository(
      appConfiguration: appConfiguration,
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
  });

  group('SigIn', () {
    Map<String, dynamic> loginSuccessJson;
<<<<<<< HEAD
    late SessionModel sessionModel;
    late SessionEntity sessionEntity;
    late EmailAddress email;
    late SignInPassword password;
=======
    SessionModel? sessionModel;
    SessionEntity? sessionEntity;
    EmailAddress? email;
    SignInPassword? password;
>>>>>>> Migrate code to nullsafety

    setUp(() async {
      loginSuccessJson =
          await JsonUtil.getJson(from: 'authentication/login_success.json');
      sessionModel = SessionModel.fromJson(loginSuccessJson);
      sessionEntity = sessionModel;
      email = EmailAddress('test@g.com');
      password = SignInPassword('_myStrongP4ss@rd', PasswordValidator());
    });

    group('device is online', () {
<<<<<<< HEAD
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
=======
      setUp(() async {
        when(networkInfo!.isConnected).thenAnswer((_) async => true);
>>>>>>> Migrate code to nullsafety
      });

      test('should return valid SessionEntity for valid user/password',
          () async {
        // arrange
        mockSignInResponse(dataSource: dataSource)
            .thenAnswer((_) async => sessionModel);
        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
<<<<<<< HEAD
        verify(
          dataSource.signInWithEmailAndPassword(
            emailAddress: email,
            password: password,
          ),
        );
=======
        verify(dataSource!.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        ));
>>>>>>> Migrate code to nullsafety

        verify(appConfiguration!.saveApiToken(token: sessionModel!.sessionToken));

        expect(result, right(sessionEntity));
      });
      test(
          'should return server failure when the call to remote server is unsuccessful',
          () async {
        // arrange
        mockSignInResponse(dataSource: dataSource)
            .thenThrow(const ApiProviderException());
        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
        expect(result, left(ServerSideFormFieldValidationFailure()));
      });
      test('should return login failure for unsuccessful user validation',
          () async {
        // arrange
        final bodyContent =
            await JsonUtil.getJson(from: 'authentication/login_failure.json');

        mockSignInResponse(dataSource: dataSource)
            .thenThrow(ApiProviderException(bodyContent: bodyContent));
        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
<<<<<<< HEAD
        verify(
          dataSource.signInWithEmailAndPassword(
            emailAddress: email,
            password: password,
          ),
        );
=======
        verify(dataSource!.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        ));
>>>>>>> Migrate code to nullsafety
        expect(
          result,
          left(
            ServerSideFormFieldValidationFailure(
              error: 'wrongpassword',
              field: 'password',
              reason: 'invalid',
              message: 'E-mail ou senha inválida.',
            ),
          ),
        );
      });
    });

    group('device is offline', () {
<<<<<<< HEAD
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
=======
      setUp(() async {
        when(networkInfo!.isConnected).thenAnswer((_) async => false);
>>>>>>> Migrate code to nullsafety
      });

      test('should return InternetConnectionFailure', () async {
        // arrange
        mockSignInResponse(dataSource: dataSource)
            .thenThrow(const ApiProviderException());
        // act
        final result = await repository.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        );
        // assert
<<<<<<< HEAD
        verify(
          dataSource.signInWithEmailAndPassword(
            emailAddress: email,
            password: password,
          ),
        );
        verify(networkInfo.isConnected);
=======
        verify(dataSource!.signInWithEmailAndPassword(
          emailAddress: email,
          password: password,
        ));
        verify(networkInfo!.isConnected);
>>>>>>> Migrate code to nullsafety
        expect(result, left(InternetConnectionFailure()));
      });
    });
  });
}

PostExpectation<dynamic> mockSignInResponse(
    {required MockAuthenticationDataSource dataSource,}) {
  return when(
    dataSource.signInWithEmailAndPassword(
      emailAddress: anyNamed('emailAddress'),
      password: anyNamed('password'),
    ),
  );
}
