enum Genre { female, male, transGirl, transBoy, others }

extension EnumGenre on Genre {
  String get rawValue {
    switch (this) {
      case Genre.male:
        return 'masculino';
      case Genre.female:
        return 'feminino';
      case Genre.transBoy:
        return 'homenTrans';
      case Genre.transGirl:
        return 'mulherTrans';
      case Genre.others:
        return 'outro';
      default:
        return 'outro';
    }
  }
}
