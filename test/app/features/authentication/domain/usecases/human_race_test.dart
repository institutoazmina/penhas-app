import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';

void main() {
  group(HumanRace, () {
    test('return correct rawValue for each human race', () {
      expect(HumanRace.white.rawValue, 'branco');
      expect(HumanRace.brown.rawValue, 'pardo');
      expect(HumanRace.black.rawValue, 'preto');
      expect(HumanRace.indigenous.rawValue, 'indigena');
      expect(HumanRace.yellow.rawValue, 'amarelo');
      expect(HumanRace.notDeclared.rawValue, 'nao_declarado');
    });

    test('return correct label for each human race', () {
      expect(HumanRace.white.label, 'Branca');
      expect(HumanRace.brown.label, 'Parda');
      expect(HumanRace.black.label, 'Preta');
      expect(HumanRace.indigenous.label, 'Índigena');
      expect(HumanRace.yellow.label, 'Amarela');
      expect(HumanRace.notDeclared.label, 'Não declarado');
    });

    test('correctly map human race from string code', () {
      expect(EnumHumanRace.map('branco'), HumanRace.white);
      expect(EnumHumanRace.map('pardo'), HumanRace.brown);
      expect(EnumHumanRace.map('preto'), HumanRace.black);
      expect(EnumHumanRace.map('indigena'), HumanRace.indigenous);
      expect(EnumHumanRace.map('amarelo'), HumanRace.yellow);
      expect(EnumHumanRace.map('nao_declarado'), HumanRace.notDeclared);
      expect(EnumHumanRace.map('unknown_code'), HumanRace.notDeclared);
      expect(EnumHumanRace.map(null), HumanRace.notDeclared);
    });
  });
}
