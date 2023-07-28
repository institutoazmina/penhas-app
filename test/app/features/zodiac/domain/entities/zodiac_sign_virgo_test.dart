import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_virgo.dart';

void main() {
  group(ZodiacSignVirgo, () {
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
      final sut = ZodiacSignVirgo();

      // assert
      expect(sut.name, 'Virgem');
      expect(sut.date, '23 AGO - 22 SET');
      expect(sut.feeling, feeling);
    });
  });
}
