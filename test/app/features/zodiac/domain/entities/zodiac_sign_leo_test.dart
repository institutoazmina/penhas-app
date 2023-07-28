import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_leo.dart';

void main() {
  group(ZodiacSignLeo, () {
    test('return correct datas', () {
      // act
      final feeling = <String>[
        'Feliz',
        'Introspectiva',
        'Estressada',
        'Ansiosa',
        'Animada',
        'Cansada',
      ];
      final sut = ZodiacSignLeo();

      // assert
      expect(sut.name, 'Leão');
      expect(sut.date, '23 JUL - 22 AGO');
      expect(sut.feeling, feeling);
    });
  });
}
