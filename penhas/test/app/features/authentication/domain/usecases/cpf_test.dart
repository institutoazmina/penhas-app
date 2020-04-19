import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';

void main() {
  group(
    "Cpf",
    () {
      test(
        'should get CpfInvalidFailure for null value',
        () {
          var result = Cpf(null).value;

          expect(result, left(CpfInvalidFailure()));
        },
      );
      test(
        'should get CpfInvalidFailure for empty value',
        () {
          var result = Cpf("").value;

          expect(result, left(CpfInvalidFailure()));
        },
      );

      test(
        'should get value from a valid cpf',
        () {
          var testValue = "236.932.813-43";
          var result = Cpf(testValue).value;

          expect(result, right(testValue));
        },
      );
    },
  );
}
