import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/data/models/session_model.dart';
import 'package:penhas/app/features/authentication/data/repositories/user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
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
import 'package:penhas/app/shared/logger/log.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  isCrashlitycsEnabled = false;

  late MockINetworkInfo networkInfo = MockINetworkInfo();
  late MockIUserRegisterDataSource dataSource = MockIUserRegisterDataSource();
  late MockIAppConfiguration appConfiguration = MockIAppConfiguration();
  late UserRegisterRepository sut = UserRegisterRepository(
    dataSource: dataSource,
    networkInfo: networkInfo,
    appConfiguration: appConfiguration,
  );
  const String SESSSION_TOKEN = 'my_really.long.JWT';

  Cep? cep;
  Cpf? cpf;
  EmailAddress? emailAddress;
  SignUpPassword? password;
  Fullname? fullname;
  Nickname? nickName;
  Birthday? birthday;
  HumanRace? race;
  Genre? genre;

  setUp(() {
    emailAddress = EmailAddress('valid@email.com');
    password = SignUpPassword('_myStr0ngP@ssw0rd', PasswordValidator());
    cep = Cep('63024-370');
    cpf = Cpf('23693281343');
    fullname = Fullname('Maria da Penha Maia Fernandes');
    nickName = Nickname('penha');
    birthday = Birthday('1994-01-01');
    race = HumanRace.brown;
    genre = Genre.female;
  });

  PostExpectation<dynamic> mockDataSourceRegister() {
    return when(dataSource.register(
      emailAddress: anyNamed('emailAddress'),
      password: anyNamed('password'),
      cep: anyNamed('cep'),
      cpf: anyNamed('cpf'),
      fullname: anyNamed('fullname'),
      nickName: anyNamed('nickName'),
      birthday: anyNamed('birthday'),
      genre: anyNamed('genre'),
      race: anyNamed('race'),
    ));
  }

  PostExpectation<dynamic> mockDataSourceCheckField() {
    return when(dataSource.checkField(
      emailAddress: anyNamed('emailAddress'),
      password: anyNamed('password'),
      cep: anyNamed('cep'),
      cpf: anyNamed('cpf'),
      fullname: anyNamed('fullname'),
      nickName: anyNamed('nickName'),
      birthday: anyNamed('birthday'),
      genre: anyNamed('genre'),
      race: anyNamed('race'),
    ));
  }

  Future<Either<Failure, SessionEntity>> executeRegister() {
    return sut.signup(
      emailAddress: emailAddress,
      password: password,
      cep: cep,
      cpf: cpf,
      fullname: fullname,
      nickName: nickName,
      birthday: birthday,
      race: race,
      genre: genre,
    );
  }

  Future<Either<Failure, ValidField>> executeCheck() {
    return sut.checkField(
      emailAddress: emailAddress,
      password: password,
      cep: cep,
      cpf: cpf,
      fullname: fullname,
      nickName: nickName,
      birthday: birthday,
      race: race,
      genre: genre,
    );
  }

  void expectedRegisterResult(
    Either<Failure, SessionEntity> result,
    Either<Failure, SessionEntity> expected,
  ) {
    verify(dataSource.register(
      emailAddress: emailAddress,
      password: password,
      cep: cep,
      cpf: cpf,
      fullname: fullname,
      nickName: nickName,
      birthday: birthday,
      genre: genre,
      race: race,
    ));
    expect(result, expected);
    verifyNoMoreInteractions(dataSource);
  }

  void expectedCheckResult(
    Either<Failure, ValidField> result,
    Either<Failure, ValidField> expected,
  ) {
    verify(dataSource.checkField(
      emailAddress: emailAddress,
      password: password,
      cep: cep,
      cpf: cpf,
      fullname: fullname,
      nickName: nickName,
      birthday: birthday,
      genre: genre,
      race: race,
    ));
    expect(result, expected);
    verifyNoMoreInteractions(dataSource);
  }

  group('UserRegisterRepository', () {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return valid SessionEntity for valid fields', () async {
        // arrange
        mockDataSourceRegister().thenAnswer(
          (_) async => const SessionModel(sessionToken: sessionToken),
        );
        // act
        final result = await executeRegister();
        // assert
        verify(appConfiguration.saveApiToken(token: SESSSION_TOKEN));
        expectedRegisterResult(
          result,
          right(const SessionEntity(sessionToken: sessionToken)),
        );
      });
      test(
          'should return ServerSideFormFieldValidationFailure for invalid field',
          () async {
        // arrange
        final serverValidation = await JsonUtil.getJson(
          from: 'authentication/registration_email_already_exists.json',
        );
        final fieldFailure = ServerSideFormFieldValidationFailure(
          error: serverValidation['error'] as String?,
          field: serverValidation['field'] as String?,
          reason: serverValidation['reason'] as String?,
          message: serverValidation['message'] as String?,
        );
        mockDataSourceRegister()
            .thenThrow(ApiProviderException(bodyContent: serverValidation));
        // act
        final result = await executeRegister();
        // assert

        verify(networkInfo.isConnected);
        expectedRegisterResult(result, left(fieldFailure));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return InternetConnectionFailure', () async {
        // arrange
        mockDataSourceRegister().thenThrow(const ApiProviderException());
        // act
        final result = await executeRegister();
        // assert
        verify(networkInfo.isConnected);
        expectedRegisterResult(result, left(InternetConnectionFailure()));
      });
    });
  });

  group('UserRegisterRepository validating field', () {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return ValidField for valid fields', () async {
        // arrange
        mockDataSourceCheckField().thenAnswer((_) async => const ValidField());
        // act
        final result = await executeCheck();
        // assert
        expectedCheckResult(result, right(const ValidField()));
      });
      test(
          'should return ServerSideFormFieldValidationFailure for invalid field',
          () async {
        // arrange
        final invalidField = await JsonUtil.getJson(
          from: 'authentication/cpf_form_field_error.json',
        );
        final fieldFailure = ServerSideFormFieldValidationFailure(
          error: invalidField['error'] as String?,
          field: invalidField['field'] as String?,
          reason: invalidField['reason'] as String?,
          message: invalidField['message'] as String?,
        );
        mockDataSourceCheckField()
            .thenThrow(ApiProviderException(bodyContent: invalidField));
        // act
        final result = await executeCheck();
        // assert
        verify(networkInfo.isConnected);
        expectedCheckResult(result, left(fieldFailure));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return InternetConnectionFailure', () async {
        // arrange
        mockDataSourceCheckField().thenThrow(const ApiProviderException());
        // act
        final result = await executeCheck();
        // assert
        verify(networkInfo.isConnected);
        expectedCheckResult(result, left(InternetConnectionFailure()));
      });
    });
  });
}
