import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';

void main() {
  group(
    'EmailAddress',
    () {
      test(
        'should get EmailAddressInvalidFailure for null email address',
        () {
          final result = EmailAddress(null).value;

          expect(result, left(EmailAddressInvalidFailure()));
        },
      );
      test(
        'should get EmailAddressInvalidFailure for empty email address',
        () {
          final result = EmailAddress('').value;

          expect(result, left(EmailAddressInvalidFailure()));
        },
      );
      test(
        'should get EmailAddressInvalidFailure for invalid email address',
        () {
          final result = EmailAddress('ola_mundo');

          expect(result.value, left(EmailAddressInvalidFailure()));
          expect(result.isValid, false);
          expect(result.rawValue, '');
        },
      );
      test(
        'should get value from a valid email address',
        () {
          final validEmailAddress = 'test@g.com';
          final result = EmailAddress(validEmailAddress);

          expect(result.value, right(validEmailAddress));
          expect(result.isValid, true);
          expect(result.rawValue, validEmailAddress);
        },
      );
    },
  );
}
