import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/help_center/domain/usecases/guardian_use_cases.dart';

void main() {
  GuardianUseCases sut;
  setUp(() {
    sut = GuardianUseCases();
  });

  group('GuardianUseCases', () {
    test('should get a empty list if there is no guardian', () async {
      // arrange
      // act
      final receceived = await sut.get();
      // assert
      expect(receceived, 0);
    });
    test('should get a list of guardians', () async {
      // arrange
      // act
      // assert
      expect(1, 0);
    });
    test('should get ok message for a valid guardian inserted', () async {
      // arrange
      // act
      // assert
      expect(1, 0);
    });
    test('should get invalid message for a invalid number', () async {
      // arrange
      // act
      // assert
      expect(1, 0);
    });
    test('should update guardian name', () async {
      // arrange
      // act
      // assert
      expect(1, 0);
    });
    test('should remove one of my guardian', () async {
      // arrange
      // act
      // assert
      expect(1, 0);
    });
  });
}
