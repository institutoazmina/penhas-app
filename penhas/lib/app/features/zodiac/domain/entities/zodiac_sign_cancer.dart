import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'izodiac.dart';

class ZodiacSignCancer implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_cancer.svg');

  @override
  String get date => '21 JUN - 22 JUL';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone => Image.asset(
        'assets/images/zodiac/icon_cancer/cancer.png',
        color: DesignSystemColors.white,
        height: 24.0,
        width: 24.0,
      );

  @override
  String get name => 'Câncer';
}
