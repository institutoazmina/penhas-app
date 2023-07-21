import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_cancer.dart';

void main() {
  group(ZodiacSignCancer, () {
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
      final sut = ZodiacSignCancer();

      // assert
      expect(sut.name, 'Câncer');
      expect(sut.date, '21 JUN - 22 JUL');
      expect(sut.feeling, feeling);
    });
  });
}
