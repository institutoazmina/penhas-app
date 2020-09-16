import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'izodiac.dart';

class ZodiacSignPisces implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_pisces.svg');

  @override
  String get date => '20 FEV - 20 MAR';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone =>
      Image.asset('assets/images/zodiac/icon_pisces/pisces.png');

  @override
  String get name => 'Peixes';
}
