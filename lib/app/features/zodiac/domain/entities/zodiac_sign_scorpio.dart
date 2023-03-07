import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/design_system/colors.dart';
import 'izodiac.dart';

class ZodiacSignScorpio implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_scorpio.svg');

  @override
  String get date => '23 OUT - 21 NOV';

  @override
  List<String> get feeling => [
        'Feliz',
        'Introspectiva',
        'Estressada',
        'Ansiosa',
        'Animada',
        'Cansada',
      ];

  @override
  Widget get icone => Image.asset(
        'assets/images/zodiac/icon_scorpio/scorpio.png',
        color: DesignSystemColors.white,
        height: 24.0,
        width: 24.0,
      );

  @override
  String get name => 'Escorpião';
}
