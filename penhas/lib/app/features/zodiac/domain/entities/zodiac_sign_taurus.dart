import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ZodiacSignTaurus implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_taurus.svg');

  @override
  String get date => '21 ABR - 20 MAI';

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
        'assets/images/zodiac/icon_taurus/taurus.png',
        color: DesignSystemColors.white,
        height: 24.0,
        width: 24.0,
      );

  @override
  String get name => 'Touro';
}
