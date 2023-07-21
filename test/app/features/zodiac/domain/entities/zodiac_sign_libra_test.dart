import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_libra.dart';

void main() {
  group(ZodiacSignLibra, () {
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
      final sut = ZodiacSignLibra();

      // assert
      expect(sut.name, 'Libra');
      expect(sut.date, '23 SET - 22 OUT');
      expect(sut.feeling, feeling);
    });
  });
}
