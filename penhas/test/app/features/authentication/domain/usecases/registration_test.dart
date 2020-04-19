import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_register_repository.dart';
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

class MockRegisterRepository extends Mock implements IRegisterRepository {}

void main() {
  RegisterUser useCase;
  MockRegisterRepository repository;

  group('registration with valid parameters', () {
    setUp(() {
      repository = MockRegisterRepository();
      useCase = RegisterUser(repository);
    });

    final emailAddress = EmailAddress("valid@email.com");
    final password = Password('_myStr0ngP@ssw0rd');
    final cep = Cep('63024-370');
    final cpf = Cpf('23693281343');
    final fullname = Fullname('Maria da Penha Maia Fernandes');
    final nickName = Nickname('penha');
    final birthday = Birthday('1994-01-01');
    final race = HumanRace('pardo');
    final genre = Genre.female;
    final successSession = SessionEntity(
      fakePassword: false,
      sessionToken: 'my_strong_session_token',
    );

    test('should get success session', () async {
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
      )).thenAnswer((_) async => right(successSession));

      final result = await useCase(
          emailAddress: emailAddress,
          password: password,
          cep: cep,
          cpf: cpf,
          fullname: fullname,
          nickName: nickName,
          birthday: birthday,
          race: race,
          genre: genre);

      expect(result, right(successSession));
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
    });
  });
}
