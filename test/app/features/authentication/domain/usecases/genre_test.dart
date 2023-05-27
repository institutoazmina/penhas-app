import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/domain/usecases/genre.dart';

void main() {
  group(Genre, () {
    test('return the correct rawValue for Genre.male', () {
      // arrange
      const genre = Genre.male;
      // act
      final result = genre.rawValue;
      // assert
      expect(result, equals('Masculino'));
    });

    test('return the correct rawValue for Genre.female', () {
      // arrange
      const genre = Genre.female;
      // act
      final result = genre.rawValue;
      // assert
      expect(result, equals('Feminino'));
    });

    test('return the correct rawValue for Genre.transBoy', () {
      // arrange
      const genre = Genre.transBoy;
      // act
      final result = genre.rawValue;
      // assert
      expect(result, equals('HomemTrans'));
    });

    test('return the correct rawValue for Genre.transGirl', () {
      // arrange
      const genre = Genre.transGirl;
      // act
      final result = genre.rawValue;
      // assert
      expect(result, equals('MulherTrans'));
    });

    test('return the correct rawValue for Genre.others', () {
      // arrange
      const genre = Genre.others;
      // act
      final result = genre.rawValue;
      // assert
      expect(result, equals('Outro'));
    });
  });
}
