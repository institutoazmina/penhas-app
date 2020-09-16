import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'izodiac.dart';

class ZodiacSignCapricorn implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_capricorn.svg');

  @override
  String get date => '22 DEZ - 20 JAN';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone =>
      Image.asset('assets/images/zodiac/icon_capricorn/capricorn.png');

  @override
  String get name => 'Capricórnio';
}
