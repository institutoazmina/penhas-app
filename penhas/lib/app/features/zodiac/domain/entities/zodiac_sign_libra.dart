import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'izodiac.dart';

class ZodiacSignLibra implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_libra.svg');

  @override
  String get date => '23 SET - 22 OUT';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone => Image.asset('assets/images/zodiac/icon_libra/libra.png');

  @override
  String get name => 'Libra';
}
