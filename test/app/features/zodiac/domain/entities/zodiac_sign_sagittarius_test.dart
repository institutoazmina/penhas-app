import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_sagittarius.dart';

void main() {
  group(ZodiacSignSagittarius, () {
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
      final sut = ZodiacSignSagittarius();

      // assert
      expect(sut.name, 'Sagitário');
      expect(sut.date, '22 NOV - 21 DEZ');
      expect(sut.feeling, feeling);
    });
  });
}
