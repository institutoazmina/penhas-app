import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_capricorn.dart';

void main() {
  group(ZodiacSignCapricorn, () {
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
      final sut = ZodiacSignCapricorn();

      // assert
      expect(sut.name, 'Capricórnio');
      expect(sut.date, '22 DEZ - 20 JAN');
      expect(sut.feeling, feeling);
    });
  });
}
