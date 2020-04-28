import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';

void main() {
  group(
    "EmailAddress",
    () {
      test(
        'should get EmailAddressInvalidFailure for null email address',
        () {
          var result = EmailAddress(null).value;

          expect(result, left(EmailAddressInvalidFailure()));
        },
      );
      test(
        'should get EmailAddressInvalidFailure for empty email address',
        () {
          var result = EmailAddress("").value;

          expect(result, left(EmailAddressInvalidFailure()));
        },
      );
      test(
        'should get EmailAddressInvalidFailure for invalid email address',
        () {
          var result = EmailAddress("ola_mundo");

          expect(result.value, left(EmailAddressInvalidFailure()));
          expect(result.isValid, false);
          expect(result.rawValue, null);
        },
      );
      test(
        'should get value from a valid email address',
        () {
          var validEmailAddress = "test@g.com";
          var result = EmailAddress(validEmailAddress);

          expect(result.value, right(validEmailAddress));
          expect(result.isValid, true);
          expect(result.rawValue, validEmailAddress);
        },
      );
    },
  );
}
