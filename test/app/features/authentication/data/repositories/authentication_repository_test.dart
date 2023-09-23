import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_in_password.dart';

import '../../../../../utils/json_util.dart';

void main() {
  late EmailAddress email;
  late SignInPassword password;
  late INetworkInfo networkInfo;
  late IAppConfiguration appConfiguration;
  late MockAuthenticationDataSource dataSource;
  late IAuthenticationRepository repository;

  setUp(() {
    email = EmailAddress('test@g.com');
    password = SignInPassword('_myStrongP4ss@rd', PasswordValidator());
    networkInfo = MockNetworkInfo();
    appConfiguration = MockAppConfiguration();
    dataSource = MockAuthenticationDataSource();

    repository = AuthenticationRepository(
      appConfiguration: appConfiguration,
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
  });

  void _mockSignInSuccessResponseWith({required SessionModel session}) {
    when(
      () => dataSource.signInWithEmailAndPassword(
        emailAddress: email,
        password: password,
      ),
    ).thenAnswer((_) async => session);
  }

  void _mockSignInErrorWith({required Exception exception}) {
    when(
      () => dataSource.signInWithEmailAndPassword(
        emailAddress: email,
        password: password,
      ),
    ).thenThrow(exception);
  }

  String _createsHash({required String password}) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  group(AuthenticationRepository, () {
    group('SigIn', () {
      Map<String, dynamic> loginSuccessJson;
      late SessionModel sessionModel;
      late SessionEntity sessionEntity;

      setUp(() async {
        loginSuccessJson =
            await JsonUtil.getJson(from: 'authentication/login_success.json');
        sessionModel = SessionModel.fromJson(loginSuccessJson);
        sessionEntity = sessionModel;
      });

      group('device is online', () {
        setUp(() {
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        });

        test(
          'return valid SessionEntity for valid user/password',
          () async {
            // arrange
            var hash = _createsHash(password: password.toString());
            _mockSignInSuccessResponseWith(session: sessionModel);
            when(() => appConfiguration.saveApiToken(
                    token: sessionModel.sessionToken))
                .thenAnswer((invocation) => Future.value());

            when(() => appConfiguration.saveHash(hash: hash))
                .thenAnswer((invocation) => Future.value());

            // act
            final result = await repository.signInWithEmailAndPassword(
              emailAddress: email,
              password: password,
            );

            // assert
            verify(
              () => dataSource.signInWithEmailAndPassword(
                emailAddress: email,
                password: password,
              ),
            ).called(1);

            verify(() => appConfiguration.saveApiToken(
                token: sessionModel.sessionToken)).called(1);

            verify(() => appConfiguration.saveHash(hash: hash)).called(1);

            expect(result, right(sessionEntity));
          },
        );
        test(
          'should return server failure when the call to remote server is unsuccessful',
          () async {
            // arrange
            _mockSignInErrorWith(exception: const ApiProviderException());
            // act
            final result = await repository.signInWithEmailAndPassword(
              emailAddress: email,
              password: password,
            );
            // assert
            expect(result, left(ServerSideFormFieldValidationFailure()));
          },
        );
        test(
          'return login failure for unsuccessful user validation',
          () async {
            // arrange
            final bodyContent = await JsonUtil.getJson(
                from: 'authentication/login_failure.json');

            _mockSignInErrorWith(
                exception: ApiProviderException(bodyContent: bodyContent));
            // act
            final result = await repository.signInWithEmailAndPassword(
              emailAddress: email,
              password: password,
            );
            // assert
            verify(
              () => dataSource.signInWithEmailAndPassword(
                emailAddress: email,
                password: password,
              ),
            ).called(1);
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
          },
        );
      });

      group('device is offline', () {
        setUp(() {
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        });

        test(
          'login offline',
          () async {
            var hash = _createsHash(password: password.toString());

            // arrange
            _mockSignInErrorWith(exception: const ApiProviderException());
            when(() => appConfiguration.apiToken).thenAnswer(
                (invocation) async => sessionModel.sessionToken as String);
            when(() => appConfiguration.offlineHash)
                .thenAnswer((invocation) async => hash);

            // act
            final result = await repository.signInWithEmailAndPassword(
              emailAddress: email,
              password: password,
            );

            verify(() => dataSource.signInWithOfflineHash(
                sessionToken: sessionModel.sessionToken as String));

            verify(() => networkInfo.isConnected).called(2);
            expect(result, left(InternetConnectionFailure()));
          },
        );
      });
    });
  });
}

class MockAuthenticationDataSource extends Mock
    implements IAuthenticationDataSource {}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockNetworkInfo extends Mock implements INetworkInfo {}
