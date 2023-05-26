import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_taurus.dart';

void main() {
  group(ZodiacSignTaurus, () {
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
      final sut = ZodiacSignTaurus();

      // assert
      expect(sut.name, 'Touro');
      expect(sut.date, '21 ABR - 20 MAI');
      expect(sut.feeling, feeling);
    });
  });
}
