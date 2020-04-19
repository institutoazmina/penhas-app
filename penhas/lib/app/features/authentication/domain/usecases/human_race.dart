enum HumanRace {
  white,
  black,
  brown,
  yellow,
  indigenous,
  notDeclared,
}

extension EnumHumanRace on HumanRace {
  String get rawValue {
    switch (this) {
      case HumanRace.white:
        return 'branco';
      case HumanRace.brown:
        return 'pardo';
      case HumanRace.black:
        return 'preto';
      case HumanRace.indigenous:
        return 'indigena';
      case HumanRace.yellow:
        return 'amarelo';
      case HumanRace.notDeclared:
        return 'nao_declarado';
      default:
        return 'nao_declarado';
    }
  }
}
