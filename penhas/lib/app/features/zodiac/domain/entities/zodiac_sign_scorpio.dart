import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'izodiac.dart';

class ZodiacSignScorpio implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_scorpio.svg');

  @override
  String get date => '23 OUT - 21 NOV';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone =>
      Image.asset('assets/images/zodiac/icon_scorpio/scorpio.png');

  @override
  String get name => 'Escorpião';
}
