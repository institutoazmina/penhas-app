import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aquarius.dart';

void main() {
  group(ZodiacSignAquarius, () {
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
      final sut = ZodiacSignAquarius();

      // assert
      expect(sut.name, 'Aquário');
      expect(sut.date, '21 JAN - 19 FEV');
      expect(sut.feeling, feeling);
    });
  });
}
