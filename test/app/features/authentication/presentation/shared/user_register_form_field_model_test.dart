import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/domain/usecases/birthday.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/domain/usecases/sign_up_password.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';

void main() {
  group(UserRegisterFormFieldModel, () {
    late UserRegisterFormFieldModel model;

    setUp(() {
      model = UserRegisterFormFieldModel();
    });

    test(
      'when Fullname is null validateFullName returns error message',
      () {
        expect(model.validateFullName, equals('Nome inválido para o sistema'));
      },
    );

    test(
      'when Fullname is not null validateFullName returns an empty string',
      () {
        model.fullname = Fullname('valid name');
        expect(model.validateFullName, equals(''));
      },
    );

    test(
      'when Email is null validateEmailAddress returns error message',
      () {
        expect(
            model.validateEmailAddress, equals('Endereço de email inválido'));
      },
    );

    test(
      'when Email is not null validateEmailAddress returns an empty string',
      () {
        model.emailAddress = EmailAddress('f@g.com');
        expect(model.validateEmailAddress, equals(''));
      },
    );

    test(
      'when Birthday is null validateBirthday return error message',
      () {
        expect(model.validateBirthday, equals('Data de nascimento inválida'));
      },
    );

    test(
      'when Birthday is not null validateBirthday return empty string',
      () {
        model.birthday = Birthday('01/01/2000');
        expect(model.validateBirthday, equals(''));
      },
    );

    test('when Cpf is null validateCpf return error message', () {
      expect(model.validateCpf, equals('CPF inválido'));
    });

    test('when Cpf is not null validateCpf return empty string', () {
      model.cpf = Cpf('12345678909');
      expect(model.validateCpf, equals(''));
    });

    test('when CEP is null validateCep returns an error message', () {
      expect(model.validateCep, equals('CEP inválido'));
    });

    test('when CEP is not null validateCep returns an empty string', () {
      model.cep = Cep('12345678');
      expect(model.validateCep, equals(''));
    });

    test(
      'validateNickname returns expected value',
      () {
        // null value
        model.nickname = null;
        expect(
            model.validateNickname, equals('Apelido inválido para o sistema'));

        /// valid value
        model.nickname = Nickname('nickname');
        expect(model.validateNickname, equals(''));
      },
    );
    test('null password and null passwordConfirmation do not crash', () {
      expect(model.validatePasswordConfirmation, equals(''));
    });
    test(
      'validatePasswordConfirmation returns expected value',
      () {
        const password = 'V3ry_str0ng_P4ssw0rd';
        // null value
        model.password = SignUpPassword(password, PasswordValidator());
        model.passwordConfirmation = null;
        expect(model.validatePasswordConfirmation,
            equals('As senhas não são iguais'));

        // valid value
        model.password = SignUpPassword(password, PasswordValidator());
        model.passwordConfirmation = password;
        expect(model.validatePasswordConfirmation, equals(''));
      },
    );

    test(
      'validateSocialName returns expected value',
      () {
        final socialName = Fullname('Social Name');
        // null gender return validateSocialName with empty string
        model.genre = null;
        model.socialName = socialName;
        expect(
          model.validateSocialName,
          equals(''),
          reason: 'null genre return validateSocialName with empty string',
        );
        // female gender return validateSocialName with empty string
        model.genre = Genre.female;
        model.socialName = socialName;
        expect(
          model.validateSocialName,
          equals(''),
          reason: 'Genre.female return validateSocialName with empty string',
        );
        // male gender return validateSocialName with empty string
        model.genre = Genre.male;
        model.socialName = socialName;
        expect(
          model.validateSocialName,
          equals(''),
          reason: 'Genre.male return validateSocialName with empty string',
        );
        //  valid genre but null socialName return validateSocialName with error message
        model.genre = Genre.others;
        model.socialName = null;
        expect(
          model.validateSocialName,
          equals('Nome inválido para o sistema'),
          reason:
              'valid genre but null socialName return validateSocialName with error message',
        );
        // valid value
        model.genre = Genre.others;
        model.socialName = socialName;
        expect(
          model.validateSocialName,
          equals(''),
          reason:
              'valid genre with socialName return validateSocialName with error message',
        );
      },
    );
  });
}
