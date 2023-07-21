import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_pisces.dart';

void main() {
  group(ZodiacSignPisces, () {
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
      final sut = ZodiacSignPisces();

      // assert
      expect(sut.name, 'Peixes');
      expect(sut.date, '20 FEV - 20 MAR');
      expect(sut.feeling, feeling);
    });
  });
}
