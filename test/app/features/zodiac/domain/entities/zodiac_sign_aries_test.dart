import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aries.dart';

void main() {
  group(ZodiacSignAries, () {
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
      final sut = ZodiacSignAries();

      // assert
      expect(sut.name, 'Áries');
      expect(sut.date, '21 MAR - 20 ABR');
      expect(sut.feeling, feeling);
    });
  });
}
