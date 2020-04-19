enum Genre { male, female }

extension EnumGenre on Genre {
  String get rawValue {
    switch (this) {
      case Genre.male:
        return 'masculino';
      case Genre.female:
        return 'feminino';
      default:
        return null;
    }
  }
}
