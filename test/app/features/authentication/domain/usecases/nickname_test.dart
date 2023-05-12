import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/nickname.dart';

void main() {
  group(
    Nickname,
    () {
      test('constructs a  Nickname with a valid string', () {
        // arrange
        const input = 'penha';
        // act
        final result = Nickname(input);
        // assert
        expect(result.rawValue, equals('penha'));
        expect(result.isValid, isTrue);
        expect(result.mapFailure, '');
        expect(result.value, right('penha'));
      });

      test('return a NicknameInvalidFailure when input is null', () {
        // arrange
        const input = null;
        // act
        final result = Nickname(input);
        // assert
        expect(result.isValid, isFalse);
        expect(result.mapFailure, 'Apelido inválido para o sistema');
        expect(result.value, equals(left(NicknameInvalidFailure())));
      });

      test('return a NicknameInvalidFailure when input is empty', () {
        // arrange
        final input = '';
        // act
        final result = Nickname(input);
        // assert
        expect(result.isValid, isFalse);
        expect(result.mapFailure, 'Apelido inválido para o sistema');
        expect(result.value, equals(left(NicknameInvalidFailure())));
      });

      test('trim whitespace from input', () {
        // arrange
        const input = '   penha      ';
        // act
        final result = Nickname(input);
        // assert
        expect(result.rawValue, equals('penha'));
        expect(result.isValid, isTrue);
        expect(result.mapFailure, '');
        expect(result.value, right('penha'));
      });
    },
  );
}
