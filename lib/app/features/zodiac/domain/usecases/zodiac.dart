import '../entities/izodiac.dart';
import '../entities/zodiac_sign_aquarius.dart';
import '../entities/zodiac_sign_aries.dart';
import '../entities/zodiac_sign_cancer.dart';
import '../entities/zodiac_sign_capricorn.dart';
import '../entities/zodiac_sign_gemini.dart';
import '../entities/zodiac_sign_leo.dart';
import '../entities/zodiac_sign_libra.dart';
import '../entities/zodiac_sign_pisces.dart';
import '../entities/zodiac_sign_sagittarius.dart';
import '../entities/zodiac_sign_scorpio.dart';
import '../entities/zodiac_sign_taurus.dart';
import '../entities/zodiac_sign_virgo.dart';

class Zodiac {
  final List<IZodiac> _signNames = [
    ZodiacSignCapricorn(),
    ZodiacSignAquarius(),
    ZodiacSignPisces(),
    ZodiacSignAries(),
    ZodiacSignTaurus(),
    ZodiacSignGemini(),
    ZodiacSignCancer(),
    ZodiacSignLeo(),
    ZodiacSignVirgo(),
    ZodiacSignLibra(),
    ZodiacSignScorpio(),
    ZodiacSignSagittarius(),
    ZodiacSignCapricorn(),
  ];

  IZodiac sign(DateTime birthday) {
    final signDays = [0, 21, 20, 21, 21, 21, 21, 23, 23, 23, 23, 22, 22];

    if (birthday.day < signDays[birthday.month]) {
      return _signNames[birthday.month - 1];
    } else {
      return _signNames[birthday.month];
    }
  }

  List<IZodiac> pickEigthRandonSign(DateTime birthday) {
    final currentSign = sign(birthday);
    final signs = _signNames;
    signs.removeWhere((e) => e.name == currentSign.name);
    signs.shuffle();
    return signs;
  }
}
