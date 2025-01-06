import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/design_system/colors.dart';
import 'izodiac.dart';

class ZodiacSignCancer implements IZodiac {
  @override
  Widget get constellation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_cancer.svg');

  @override
  String get date => '21 JUN - 22 JUL';

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
  Widget get icon => Image.asset(
        'assets/images/zodiac/icon_cancer/cancer.png',
        color: DesignSystemColors.white,
        height: 24.0,
        width: 24.0,
      );

  @override
  String get name => 'Câncer';
}
