enum Genre { female, male, transGirl, transBoy, others }

extension EnumGenre on Genre? {
  String? get rawValue {
    String? genre;
    switch (this) {
      case Genre.male:
        genre = 'Masculino';
        break;
      case Genre.female:
        genre = 'Feminino';
        break;
      case Genre.transBoy:
        genre = 'HomemTrans';
        break;
      case Genre.transGirl:
        genre = 'MulherTrans';
        break;
      case Genre.others:
        genre = 'Outro';
        break;
    }

    return genre;
  }
}
