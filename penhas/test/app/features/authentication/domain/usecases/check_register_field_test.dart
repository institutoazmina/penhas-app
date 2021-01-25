import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/check_register_field.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';

class MockRegisterRepository extends Mock implements IUserRegisterRepository {}

void main() {
  CheckRegisterField sut;
  MockRegisterRepository repository;
  Cep cep;
  Cpf cpf;
  EmailAddress emailAddress;
  SignUpPassword password;
  Fullname fullname;
  Nickname nickName;
  Birthday birthday;
  HumanRace race;
  Genre genre;

  setUp(() {
    repository = MockRegisterRepository();
    sut = CheckRegisterField(repository);
    emailAddress = EmailAddress("valid@email.com");
    password = SignUpPassword('_myStr0ngP@ssw0rd', PasswordValidator());
    cep = Cep('63024-370');
    cpf = Cpf('23693281343');
    fullname = Fullname('Maria da Penha Maia Fernandes');
    nickName = Nickname('penha');
    birthday = Birthday('1994-01-01');
    race = HumanRace.brown;
    genre = Genre.female;
  });

  Future<Either<Failure, ValidField>> runRegister() async {
    return sut(
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

  void mockRepositoryRegister(Either<Failure, ValidField> answer) {
    when(repository.checkField(
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

  void expectResult(Either<Failure, ValidField> result,
      Either<Failure, ValidField> expected) {
    expect(result, expected);
    verify(repository.checkField(
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

  group('CheckRegisterField', () {
    test('should get error for empty CheckRegisterField()', () async {
      // arrange
      mockRepositoryRegister(left(RequiredParameter()));
      // act
      final result = await sut();
      // assert
      expect(result, left(RequiredParameter()));
      verifyZeroInteractions(repository);
    });

    test(
        'should get ServerSideFormFieldValidationFailure message for validate fields',
        () async {
      // arrange
      mockRepositoryRegister(left(ServerSideFormFieldValidationFailure()));
      // act
      final result = await runRegister();
      // assert
      expectResult(result, left(ServerSideFormFieldValidationFailure()));
    });

    test('should get ValidField message for valid field', () async {
      // arrange
      mockRepositoryRegister(right(ValidField()));
      // act
      final result = await runRegister();
      // assert
      expectResult(result, right(ValidField()));
    });
  });
}
