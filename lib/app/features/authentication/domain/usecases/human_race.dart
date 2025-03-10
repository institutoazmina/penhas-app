enum HumanRace {
  brown,
  black,
  yellow,
  indigenous,
  white,
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
    }
  }

  String get label {
    String? label;
    switch (this) {
      case HumanRace.white:
        label = 'Branca';
        break;
      case HumanRace.brown:
        label = 'Parda';
        break;
      case HumanRace.black:
        label = 'Preta';
        break;
      case HumanRace.indigenous:
        label = 'Indígena';
        break;
      case HumanRace.yellow:
        label = 'Amarela';
        break;
      case HumanRace.notDeclared:
        label = 'Não declarado';
        break;
    }

    return label;
  }

  static HumanRace map(String? code) {
    if (code == null) {
      return HumanRace.notDeclared;
    }

    if (code.toLowerCase() == 'branco') {
      return HumanRace.white;
    } else if (code.toLowerCase() == 'pardo') {
      return HumanRace.brown;
    } else if (code.toLowerCase() == 'preto') {
      return HumanRace.black;
    } else if (code.toLowerCase() == 'indigena') {
      return HumanRace.indigenous;
    } else if (code.toLowerCase() == 'amarelo') {
      return HumanRace.yellow;
    } else if (code.toLowerCase() == 'nao_declarado') {
      return HumanRace.notDeclared;
    } else {
      return HumanRace.notDeclared;
    }
  }
}
