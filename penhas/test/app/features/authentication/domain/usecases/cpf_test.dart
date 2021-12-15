import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';

void main() {
  group(
    'Cpf',
    () {
      test(
        'should get CpfInvalidFailure for null value',
        () {
          var result = Cpf("").value;

          expect(result, left(CpfInvalidFailure()));
        },
      );
      test(
        'should get CpfInvalidFailure for empty value',
        () {
          final result = Cpf('').value;

          expect(result, left(CpfInvalidFailure()));
        },
      );

      test(
        'should get value from a valid cpf',
        () {
          const testValue = '236.932.813-43';
          final result = Cpf(testValue).value;

          expect(result, right('23693281343'));
        },
      );
    },
  );
}
