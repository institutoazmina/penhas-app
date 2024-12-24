import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cpf.dart';

void main() {
  group(
    Cpf,
    () {
      test('constructs a Cpf with valid string', () {
        // arrange
        const cpfString = '529.982.247-25';
        // act
        final cpf = Cpf(cpfString);
        // assert
        expect(cpf.isValid, true);
        expect(cpf.rawValue, '52998224725');
        expect(cpf.mapFailure, '');
      });
      test(
        'returns invalid Cpf when constructed with invalid value',
        () {
          // arrange
          const cpfString = '52A.A82.247-25';
          // act
          final cpf = Cpf(cpfString);
          // assert
          expect(cpf.isValid, false);
          expect(cpf.mapFailure, 'CPF inválido');
          expect(cpf.value, left(CpfInvalidFailure()));
        },
      );
      test(
        'returns invalid Cpf when constructed with empty value',
        () {
          // arrange
          const cpfString = '';
          // act
          final cpf = Cpf(cpfString);
          // assert
          expect(cpf.isValid, false);
          expect(cpf.mapFailure, 'CPF inválido');
          expect(cpf.value, left(CpfInvalidFailure()));
        },
      );

      test('return true for equal Cpf', () {
        // arrange
        const cpfString = '529.982.247-25';
        // act
        final cpf = Cpf(cpfString);
        final cpf2 = Cpf(cpfString);
        // assert
        expect(cpf == cpf2, true);
      });

      test('return false for different Cpf', () {
        // arrange
        const cpfString = '529.982.247-25';
        const cpfString2 = '529.982.247-26';
        // act
        final cpf = Cpf(cpfString);
        final cpf2 = Cpf(cpfString2);
        // assert
        expect(cpf == cpf2, false);
      });
    },
  );
}
