import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';

void main() {
  group(
    Cep,
    () {
      test('constructs a Cep with valid string', () {
        // arrange
        const cepString = '63024-370';
        // act
        final cep = Cep(cepString);
        // assert
        expect(cep.isValid, true);
        expect(cep.rawValue, '63024370');
        expect(cep.mapFailure, '');
      });

      test('constructs a Cep with valid string without hyphen', () {
        // arrange
        const cepString = '63024370';
        // act
        final cep = Cep(cepString);
        // assert
        expect(cep.isValid, true);
        expect(cep.rawValue, '63024370');
        expect(cep.mapFailure, '');
      });

      test(
          'returns invalid Cep when constructed with string with less than 8 digits',
          () {
        // arrange
        const cepString = '6302437';
        // act
        final cep = Cep(cepString);
        // assert
        expect(cep.isValid, false);
        expect(cep.mapFailure, 'CEP inválido');
        expect(cep.value, left(CepInvalidFailure()));
      });

      test('returns invalid Cep when constructed with null', () {
        final cep = Cep(null);

        expect(cep.isValid, false);
        expect(cep.mapFailure, 'CEP inválido');
        expect(cep.value, left(CepInvalidFailure()));
      });

      test('return true for equals Ceps', () {
        // arrange
        const cepString = '63024-370';
        // act
        final cep1 = Cep(cepString);
        final cep2 = Cep(cepString);
        // assert
        expect(cep1 == cep2, true);
      });

      test('return false for different Ceps', () {
        // arrange
        const cepString1 = '63024-370';
        const cepString2 = '63024-371';
        // act
        final cep1 = Cep(cepString1);
        final cep2 = Cep(cepString2);
        // assert
        expect(cep1 == cep2, false);
      });
    },
  );
}
