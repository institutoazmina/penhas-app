import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/full_name.dart';

void main() {
  group(
    Fullname,
    () {
      test('constructs a FullName with a valid full name', () {
        // arrange
        const name = 'Maria da Penha Maia Fernandes';
        // act
        final result = Fullname(name);
        // assert
        expect(result.rawValue, equals('Maria da Penha Maia Fernandes'));
        expect(result.isValid, isTrue);
        expect(result.value, right(name));
      });

      test(
        'return a FullnameInvalidFailure when input is null',
        () {
          // arrange
          const input = null;
          // act
          final result = Fullname(input);
          // assert
          expect(result.isValid, isFalse);
          expect(result.value, left(FullnameInvalidFailure()));
          expect(result.mapFailure, 'Nome inválido para o sistema');
        },
      );
      test(
        'return a FullnameInvalidFailure when input is empty',
        () {
          // arrange
          const input = '';
          // act
          final result = Fullname(input);
          // assert
          expect(result.isValid, isFalse);
          expect(result.value, left(FullnameInvalidFailure()));
          expect(result.mapFailure, 'Nome inválido para o sistema');
        },
      );
      test('trim whitespace from input', () {
        // arrange
        const name = '       Maria da Penha Maia Fernandes     ';
        // act
        final result = Fullname(name);
        // assert
        expect(result.rawValue, equals('Maria da Penha Maia Fernandes'));
        expect(result.isValid, isTrue);
        expect(result.value, right('Maria da Penha Maia Fernandes'));
      });

      test('return true for equal FullName', () {
        // arrange
        const name = '       Maria da Penha Maia Fernandes     ';
        // act
        final result = Fullname(name);
        final result2 = Fullname(name);
        // assert
        expect(result == result2, isTrue);
      });

      test('return false for different FullName', () {
        // arrange
        const name = 'Maria One';
        const name2 = 'Maria Two';
        // act
        final result = Fullname(name);
        final result2 = Fullname(name2);
        // assert
        expect(result == result2, isFalse);
      });
    },
  );
}
