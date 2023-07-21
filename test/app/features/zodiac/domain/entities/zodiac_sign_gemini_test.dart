import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_gemini.dart';

void main() {
  group(ZodiacSignGemini, () {
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
      final sut = ZodiacSignGemini();

      // assert
      expect(sut.name, 'Gêmeos');
      expect(sut.date, '21 MAI - 20 JUN');
      expect(sut.feeling, feeling);
    });
  });
}
