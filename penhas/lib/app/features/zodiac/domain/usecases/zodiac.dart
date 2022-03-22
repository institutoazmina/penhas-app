import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aquarius.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_aries.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_cancer.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_capricorn.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_gemini.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_leo.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_libra.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_pisces.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_sagittarius.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_scorpio.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_taurus.dart';
import 'package:penhas/app/features/zodiac/domain/entities/zodiac_sign_virgo.dart';

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

  IZodiac sign(DateTime birthdate) {
    const List<int> signDays = [0, 22, 20, 21, 21, 22, 23, 23, 23, 23, 22, 22];

    if (birthdate.day < signDays[birthdate.month]) {
      return _signNames[birthdate.month - 1];
    } else {
      return _signNames[birthdate.month];
    }
  }

  List<IZodiac> pickEigthRandonSign(DateTime birthdate) {
    final currentSign = sign(birthdate);
    final signs = _signNames;
    signs.removeWhere((e) => e.name == currentSign.name);
    signs.shuffle();
    return signs;
  }
}
