import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';

void main() {
  group(
    "Cep",
    () {
      test(
        'should get CepInvalidFailure for null value',
        () {
          var result = Cep(null).value;

          expect(result, left(CepInvalidFailure()));
        },
      );
      test(
        'should get CepInvalidFailure for empty value',
        () {
          var result = Cep("").value;

          expect(result, left(CepInvalidFailure()));
        },
      );

      test(
        'should get value from a valid cep',
        () {
          var testValue = "63024-370";
          var result = Cep(testValue).value;

          expect(result, right('63024370'));
        },
      );
    },
  );
}
