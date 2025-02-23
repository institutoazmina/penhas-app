import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/data/repositories/user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

import '../../../../../utils/api_provider_mock.dart';
import '../../../../../utils/json_util.dart';

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockIApiServerConfigure extends Mock implements IApiServerConfigure {}

void main() {
  late IAppConfiguration appConfiguration;
  late IApiServerConfigure serverConfigure;
  late UserRegisterRepository sut;

  late Cep cep;
  late Cpf cpf;
  late EmailAddress emailAddress;
  late SignUpPassword password;
  late Fullname fullName;
  late Fullname socialName;
  late Nickname nickName;
  late Birthday birthday;
  late Genre genre;
  late HumanRace race;

  const contentType = 'application/x-www-form-urlencoded; charset=utf-8';

  setUp(() {
    ApiProviderMock.init();

    serverConfigure = MockIApiServerConfigure();
    appConfiguration = MockAppConfiguration();
    sut = UserRegisterRepository(
      apiProvider: ApiProviderMock.apiProvider,
      appConfiguration: appConfiguration,
      serverConfigure: serverConfigure,
    );

    emailAddress = EmailAddress('valid@email.com');
    password = SignUpPassword('_myStr0ngP@ssw0rd', PasswordValidator());
    cep = Cep('63024-370');
    cpf = Cpf('23693281343');
    fullName = Fullname('Maria da Penha Maia Fernandes');
    socialName = Fullname('Maria da Penha');
    nickName = Nickname('penha');
    birthday = Birthday('01/01/1994');
    race = HumanRace.brown;
    genre = Genre.female;

    when(() => serverConfigure.userAgent).thenAnswer((_) async => '1.0.0');

    when(() => appConfiguration.saveApiToken(token: any(named: 'token')))
        .thenAnswer((invocation) => Future.value());
  });

  void _setUpMockHttpClientResponse(String body, {int? statusCode}) {
    ApiProviderMock.apiClientResponse(body, statusCode ?? 200);
  }

  group(UserRegisterRepository, () {
    group('checkField()', () {
      test(
        'return ValidField when all fields are valid',
        () async {
          // arrange
          final jsonScript = '{"continue": 1}';
          _setUpMockHttpClientResponse(jsonScript);
          final actualResult = ValidField.fromJson(jsonDecode(jsonScript));
          // act
          final result = await sut.checkField(
            emailAddress: emailAddress,
            password: password,
            cep: cep,
            fullname: fullName,
            socialName: socialName,
            cpf: cpf,
            race: race,
            nickName: nickName,
            birthday: birthday,
            genre: genre,
          );
          // assert
          final request = verify(
            () => ApiProviderMock.httpClient.send(captureAny()),
          ).captured.single;

          expect(request.url.path, '/signup');
          expect(request.method, 'POST');
          expect(request.headers['Content-Type'], contentType);
          expect(request.url.queryParameters, {
            'app_version': '1.0.0',
            'dry': '1',
            'email': emailAddress.rawValue,
            'senha': password.rawValue,
            'cep': cep.rawValue,
            'nome_completo': fullName.rawValue,
            'nome_social': socialName.rawValue,
            'cpf': cpf.rawValue,
            'raca': race.rawValue,
            'apelido': nickName.rawValue,
            'dt_nasc': birthday.rawValue,
            'genero': genre.rawValue,
          });
          expect(result.fold(id, id), actualResult);
        },
      );

      test(
        'return ServerSideFormFieldValidationFailure when email already exists',
        () async {
          // arrange
          final jsonFile =
              'authentication/registration_email_already_exists.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final jsonString = JsonUtil.getStringSync(from: jsonFile);
          final actualResult = ServerSideFormFieldValidationFailure(
            error: jsonData['error'],
            message: jsonData['message'],
            field: jsonData['field'],
            reason: jsonData['reason'],
          );
          _setUpMockHttpClientResponse(jsonString, statusCode: 400);
          // act
          final result = await sut.checkField(
            emailAddress: emailAddress,
            password: password,
            cep: cep,
            fullname: fullName,
            socialName: socialName,
            cpf: cpf,
            race: race,
            nickName: nickName,
            birthday: birthday,
            genre: genre,
          );
          // assert
          expect(result.fold(id, id), actualResult);
        },
      );
    });
    group('signup()', () {
      test(
        'return SessionEntity when all fields are valid',
        () async {
          // arrange
          final jsonFile = 'authentication/login_success.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final jsonString = JsonUtil.getStringSync(from: jsonFile);
          final actualResult = SessionModel.fromJson(jsonData);
          _setUpMockHttpClientResponse(jsonString);
          // act
          final result = await sut.signup(
            emailAddress: emailAddress,
            password: password,
            cep: cep,
            fullname: fullName,
            socialName: socialName,
            cpf: cpf,
            race: race,
            nickName: nickName,
            birthday: birthday,
            genre: genre,
          );
          // assert
          final request = verify(
            () => ApiProviderMock.httpClient.send(captureAny()),
          ).captured.single;

          expect(request.url.path, '/signup');
          expect(request.method, 'POST');
          expect(request.headers['Content-Type'], contentType);
          expect(request.url.queryParameters, {
            'app_version': '1.0.0',
            'dry': '0',
            'email': emailAddress.rawValue,
            'senha': password.rawValue,
            'cep': cep.rawValue,
            'nome_completo': fullName.rawValue,
            'nome_social': socialName.rawValue,
            'cpf': cpf.rawValue,
            'raca': race.rawValue,
            'apelido': nickName.rawValue,
            'dt_nasc': birthday.rawValue,
            'genero': genre.rawValue,
          });
          expect(result.fold(id, id), actualResult);
        },
      );

      test(
        'return ServerSideFormFieldValidationFailure when email already exists',
        () async {
          // arrange
          final jsonFile =
              'authentication/registration_email_already_exists.json';
          final jsonData = await JsonUtil.getJson(from: jsonFile);
          final jsonString = JsonUtil.getStringSync(from: jsonFile);
          final actualResult = ServerSideFormFieldValidationFailure(
            error: jsonData['error'],
            message: jsonData['message'],
            field: jsonData['field'],
            reason: jsonData['reason'],
          );
          _setUpMockHttpClientResponse(jsonString, statusCode: 400);
          // act
          final result = await sut.signup(
            emailAddress: emailAddress,
            password: password,
            cep: cep,
            fullname: fullName,
            socialName: socialName,
            cpf: cpf,
            race: race,
            nickName: nickName,
            birthday: birthday,
            genre: genre,
          );
          // assert
          expect(result.fold(id, id), actualResult);
        },
      );
    });
  });
}
