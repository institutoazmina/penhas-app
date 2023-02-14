import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/authentication/data/datasources/user_register_data_source.dart';
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

import '../../../../../utils/json_util.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockUserRegisterDataSource extends Mock
    implements IUserRegisterDataSource {}

void main() {
  late INetworkInfo networkInfo;
  late IUserRegisterDataSource dataSource;
  late IAppConfiguration appConfiguration;
  late UserRegisterRepository sut;

  late Cep cep;
  late Cpf cpf;
  late EmailAddress emailAddress;
  late SignUpPassword? password;
  late Fullname fullname;
  late Nickname nickName;
  late Birthday birthday;
  late HumanRace race;
  late Genre genre;

  const String sessionToken = 'my_really.long.JWT';

  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockUserRegisterDataSource();
    appConfiguration = MockAppConfiguration();
    sut = UserRegisterRepository(
      dataSource: dataSource,
      networkInfo: networkInfo,
      appConfiguration: appConfiguration,
    );

    emailAddress = EmailAddress('valid@email.com');
    password = SignUpPassword('_myStr0ngP@ssw0rd', PasswordValidator());
    cep = Cep('63024-370');
    cpf = Cpf('23693281343');
    fullname = Fullname('Maria da Penha Maia Fernandes');
    nickName = Nickname('penha');
    birthday = Birthday('1994-01-01');
    race = HumanRace.brown;
    genre = Genre.female;

    when(() => appConfiguration.saveApiToken(token: sessionToken))
        .thenAnswer((invocation) => Future.value());
  });

  void dataSourceRegisterWithException(Object throwable) {
    when(
      () => dataSource.register(
        emailAddress: emailAddress,
        password: password,
        cep: cep,
        cpf: cpf,
        fullname: fullname,
        nickName: nickName,
        birthday: birthday,
        genre: genre,
        race: race,
        socialName: null,
      ),
    ).thenThrow(throwable);
  }

  void dataSourceRegisterReturn(SessionModel value) {
    when(
      () => dataSource.register(
        emailAddress: emailAddress,
        password: password,
        cep: cep,
        cpf: cpf,
        fullname: fullname,
        nickName: nickName,
        birthday: birthday,
        genre: genre,
        race: race,
        socialName: null,
      ),
    ).thenAnswer((_) async => value);
  }

  void dataSourceSuccessCheckField() {
    when(
      () => dataSource.checkField(
          emailAddress: emailAddress,
          password: password,
          cep: cep,
          cpf: cpf,
          fullname: fullname,
          nickName: nickName,
          birthday: birthday,
          genre: genre,
          race: race),
    ).thenAnswer((_) async => const ValidField());
  }

  void dataSourceCheckFieldWithException(Object throwable) {
    when(
      () => dataSource.checkField(
          emailAddress: emailAddress,
          password: password,
          cep: cep,
          cpf: cpf,
          fullname: fullname,
          nickName: nickName,
          birthday: birthday,
          genre: genre,
          race: race),
    ).thenThrow(throwable);
  }

  Future<Either<Failure, SessionEntity>> executeUserSignUp() {
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

  void expectedUserSignUpResult(
    Either<Failure, SessionEntity> result,
    Either<Failure, SessionEntity> expected,
  ) {
    verify(
      () => dataSource.register(
        emailAddress: emailAddress,
        password: password,
        cep: cep,
        cpf: cpf,
        fullname: fullname,
        nickName: nickName,
        birthday: birthday,
        genre: genre,
        race: race,
        socialName: null,
      ),
    ).called(1);
    expect(result, expected);
    verifyNoMoreInteractions(dataSource);
  }

  Future<Either<Failure, ValidField>> executeUserCheckField() {
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

  void expectedCheckResult(
    Either<Failure, ValidField> result,
    Either<Failure, ValidField> expected,
  ) {
    verify(
      () => dataSource.checkField(
        emailAddress: emailAddress,
        password: password,
        cep: cep,
        cpf: cpf,
        fullname: fullname,
        nickName: nickName,
        birthday: birthday,
        genre: genre,
        race: race,
      ),
    ).called(1);
    expect(result, expected);
    verifyNoMoreInteractions(dataSource);
  }

  group(UserRegisterRepository, () {
    group('signup()', () {
      group('device is online', () {
        setUp(() {
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        });

        test(
          'return valid SessionEntity for valid fields',
          () async {
            // arrange
            dataSourceRegisterReturn(SessionModel(sessionToken: sessionToken));
            // act
            final result = await executeUserSignUp();
            // assert
            verify(() => appConfiguration.saveApiToken(token: sessionToken))
                .called(1);
            expectedUserSignUpResult(
              result,
              right(const SessionEntity(sessionToken: sessionToken)),
            );
          },
        );
        test(
          'return ServerSideFormFieldValidationFailure for invalid field',
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
            dataSourceRegisterWithException(
                ApiProviderException(bodyContent: serverValidation));
            // act
            final result = await executeUserSignUp();
            // assert
            verify(() => networkInfo.isConnected).called(1);
            expectedUserSignUpResult(result, left(fieldFailure));
          },
        );
      });

      group('device is offline', () {
        setUp(() {
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        });

        test(
          'return InternetConnectionFailure',
          () async {
            // arrange
            dataSourceRegisterWithException(ApiProviderException());
            // act
            final result = await executeUserSignUp();
            // assert
            verify(() => networkInfo.isConnected).called(1);
            expectedUserSignUpResult(result, left(InternetConnectionFailure()));
          },
        );
      });
    });

    group('checkField()', () {
      group('device is online', () {
        setUp(() {
          when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        });
        test(
          'return ValidField for valid fields',
          () async {
            // arrange
            dataSourceSuccessCheckField();
            // act
            final result = await executeUserCheckField();
            // assert
            expectedCheckResult(result, right(const ValidField()));
          },
        );
        test(
          'return ServerSideFormFieldValidationFailure for invalid field',
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
            dataSourceCheckFieldWithException(
                ApiProviderException(bodyContent: invalidField));
            // act
            final result = await executeUserCheckField();
            // assert
            verify(() => networkInfo.isConnected);
            expectedCheckResult(result, left(fieldFailure));
          },
        );
      });
      group('device is offline', () {
        setUp(() {
          when(() => networkInfo.isConnected).thenAnswer((_) async => false);
        });
        test(
          'return InternetConnectionFailure',
          () async {
            // arrange
            dataSourceCheckFieldWithException(ApiProviderException());
            // act
            final result = await executeUserCheckField();
            // assert
            verify(() => networkInfo.isConnected);
            expectedCheckResult(result, left(InternetConnectionFailure()));
          },
        );
      });
    });
  });
}
