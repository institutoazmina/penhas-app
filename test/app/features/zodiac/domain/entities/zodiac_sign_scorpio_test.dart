import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_scorpio.dart';

void main() {
  group(ZodiacSignScorpio, () {
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
      final sut = ZodiacSignScorpio();

      // assert
      expect(sut.name, 'Escorpião');
      expect(sut.date, '23 OUT - 21 NOV');
      expect(sut.feeling, feeling);
    });
  });
}
