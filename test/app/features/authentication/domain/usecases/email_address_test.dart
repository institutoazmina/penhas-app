import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';

void main() {
  group(EmailAddress, () {
    test('constructs an EmailAddress with valid email', () {
      // arrange
      const emailString = 'test@example.com';
      // act
      final emailAddress = EmailAddress(emailString);
      // assert
      expect(emailAddress.isValid, true);
      expect(emailAddress.rawValue, emailString);
      expect(emailAddress.mapFailure, '');
    });

    test('returns invalid EmailAddress when constructed with invalid email',
        () {
      // arrange
      const emailString = 'invalid_email';
      // act
      final emailAddress = EmailAddress(emailString);
      // assert
      expect(emailAddress.isValid, false);
      expect(emailAddress.mapFailure, 'Endereço de email inválido');
      expect(emailAddress.value, left(EmailAddressInvalidFailure()));
    });

    test('returns invalid EmailAddress when constructed with empty email', () {
      // arrange
      const emailString = '';
      // act
      final emailAddress = EmailAddress(emailString);
      // assert
      expect(emailAddress.isValid, false);
      expect(emailAddress.mapFailure, 'Endereço de email inválido');
      expect(emailAddress.value, left(EmailAddressInvalidFailure()));
    });

    test('returns invalid EmailAddress when constructed with null', () {
      // act
      final emailAddress = EmailAddress(null);
      // assert
      expect(emailAddress.isValid, false);
      expect(emailAddress.mapFailure, 'Endereço de email inválido');
      expect(emailAddress.value, left(EmailAddressInvalidFailure()));
    });

    test('return true for equal EmailAddress', () {
      // arrange
      const emailString = 'test@g.com';
      // act
      final emailAddress = EmailAddress(emailString);
      final emailAddress2 = EmailAddress(emailString);
      // assert
      expect(emailAddress == emailAddress2, true);
    });

    test('return false for different EmailAddress', () {
      // arrange
      const emailString = 'test@g.com';
      const emailString2 = 'test2@g.com';
      // act
      final emailAddress = EmailAddress(emailString);
      final emailAddress2 = EmailAddress(emailString2);
      // assert
      expect(emailAddress == emailAddress2, false);
    });
  });
}
