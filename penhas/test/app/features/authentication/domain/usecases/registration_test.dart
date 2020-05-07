import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password.dart';
import 'package:penhas/app/features/authentication/domain/usecases/register_user.dart';

class MockRegisterRepository extends Mock implements IUserRegisterRepository {}

class MockAppConfiguration extends Mock implements IAppConfiguration {}

void main() {
  RegisterUser useCase;
  MockRegisterRepository repository;
  MockAppConfiguration appConfiguration;

  Cep cep;
  Cpf cpf;
  EmailAddress emailAddress;
  Password password;
  Fullname fullname;
  Nickname nickName;
  Birthday birthday;
  HumanRace race;
  Genre genre;
  SessionEntity successSession;

  group('SignUp', () {
    setUp(() {
      repository = MockRegisterRepository();
      appConfiguration = MockAppConfiguration();
      useCase = RegisterUser(
          appConfiguration: appConfiguration,
          authenticationRepository: repository);
      emailAddress = EmailAddress("valid@email.com");
      password = Password('_myStr0ngP@ssw0rd');
      cep = Cep('63024-370');
      cpf = Cpf('23693281343');
      fullname = Fullname('Maria da Penha Maia Fernandes');
      nickName = Nickname('penha');
      birthday = Birthday('1994-01-01');
      race = HumanRace.brown;
      genre = Genre.female;
      successSession = SessionEntity(
        sessionToken: 'my_strong_session_token',
      );

      when(appConfiguration.saveApiToken(token: anyNamed('token')))
          .thenAnswer((_) async => Future.value());
    });
    group('with valid parameters', () {
      Future<Either<Failure, SessionEntity>> runRegister() async {
        return useCase(
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

      void mockRepositoryRegister(Either<Failure, SessionEntity> answer) {
        when(repository.signup(
          emailAddress: anyNamed('emailAddress'),
          password: anyNamed('password'),
          cep: anyNamed('cep'),
          cpf: anyNamed('cpf'),
          fullname: anyNamed('fullname'),
          nickName: anyNamed('nickName'),
          birthday: anyNamed('birthday'),
          genre: anyNamed('genre'),
          race: anyNamed('race'),
        )).thenAnswer((_) async => answer);
      }

      void expectResult(Either<Failure, SessionEntity> result,
          Either<Failure, SessionEntity> expected) {
        expect(result, expected);
        verify(repository.signup(
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
        verifyNoMoreInteractions(repository);
      }

      test('should get success session', () async {
        // arrange
        mockRepositoryRegister(right(successSession));
        // act
        final result = await runRegister();
        // assert
        expectResult(result, right(successSession));
      });

      test('could get error for form field validation from server', () async {
        // arrange
        mockRepositoryRegister(left(ServerSideFormFieldValidationFailure()));
        // act
        final result = await runRegister();
        // assert
        expectResult(result, left(ServerSideFormFieldValidationFailure()));
      });
    });
  });
}
