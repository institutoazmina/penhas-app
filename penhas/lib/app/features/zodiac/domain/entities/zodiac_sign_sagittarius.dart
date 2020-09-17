import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'izodiac.dart';

class ZodiacSignSagittarius implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_sagittarius.svg');

  @override
  String get date => '22 NOV - 21 DEZ';

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
        'assets/images/zodiac/icon_sagittarius/sagittarius.png',
        color: DesignSystemColors.white,
        height: 24.0,
        width: 24.0,
      );

  @override
  String get name => 'Sagitário';
}
