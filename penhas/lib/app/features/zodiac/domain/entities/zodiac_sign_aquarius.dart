import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'izodiac.dart';

class ZodiacSignAquarius implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_aquarius.svg');

  @override
  String get date => '21 JAN - 19 FEV';

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
        'assets/images/zodiac/icon_aquarius/aquarius.png',
        color: DesignSystemColors.white,
        height: 24.0,
        width: 24.0,
      );

  @override
  String get name => 'Aquário';
}
