import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/error/failures.dart';
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
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';

import '../../../../../utils/json_util.dart';

class MockUserRegisterDataSource extends Mock
    implements IUserRegisterDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  INetworkInfo networkInfo;
  IUserRegisterDataSource dataSource;
  UserRegisterRepository sut;
  const String SESSSION_TOKEN = 'my_really.long.JWT';

  Cep cep;
  Cpf cpf;
  EmailAddress emailAddress;
  Password password;
  Fullname fullname;
  Nickname nickName;
  Birthday birthday;
  HumanRace race;
  Genre genre;

  setUp(() {
    emailAddress = EmailAddress("valid@email.com");
    password = Password('_myStr0ngP@ssw0rd');
    cep = Cep('63024-370');
    cpf = Cpf('23693281343');
    fullname = Fullname('Maria da Penha Maia Fernandes');
    nickName = Nickname('penha');
    birthday = Birthday('1994-01-01');
    race = HumanRace.brown;
    genre = Genre.female;
    dataSource = MockUserRegisterDataSource();
    networkInfo = MockNetworkInfo();
    sut = UserRegisterRepository(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
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

  Future<Either<Failure, SessionEntity>> executeSut() {
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

  void expectedResult(
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

  group('UserRegisterRepository', () {
    group('device is online', () {
      setUp(() async {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return valid SessionEntity for valid fields', () async {
        // arrange
        mockDataSourceRegister().thenAnswer(
          (_) async => SessionModel(sessionToken: SESSSION_TOKEN),
        );
        // act
        final result = await executeSut();
        // assert
        expectedResult(
          result,
          right(SessionEntity(sessionToken: SESSSION_TOKEN)),
        );
      });
      test(
          'should return ServerSideFormFieldValidationFailure for invalid field',
          () async {
        // arrange
        final serverValidation = await JsonUtil.getJson(
            from: 'authentication/registration_email_already_exists.json');
        mockDataSourceRegister()
            .thenThrow(ApiProviderException(bodyContent: serverValidation));
        // act
        final result = await executeSut();
        // assert
        final fieldFailure = ServerSideFormFieldValidationFailure(
          error: serverValidation['error'],
          field: serverValidation['field'],
          reason: serverValidation['reason'],
          message: serverValidation['message'],
        );
        expectedResult(result, left(fieldFailure));
      });
    });
  });
}
