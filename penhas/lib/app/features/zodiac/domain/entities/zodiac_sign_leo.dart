import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'izodiac.dart';

class ZodiacSignLeo implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_leo.svg');

  @override
  String get date => '23 JUL - 22 AGO';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone => Image.asset('assets/images/zodiac/icon_leo/leo.png');

  @override
  String get name => 'Leão';
}
