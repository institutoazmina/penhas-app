import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ZodiacSignVirgo implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_virgo.svg');

  @override
  String get date => '23 AGO - 22 SET';

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
        'assets/images/zodiac/icon_virgo/virgo.png',
        color: DesignSystemColors.white,
        height: 24.0,
        width: 24.0,
      );

  @override
  String get name => 'Virgem';
}
