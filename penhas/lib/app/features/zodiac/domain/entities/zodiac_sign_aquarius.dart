import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'izodiac.dart';

class ZodiacSignAquarius implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_aquarius.svg');

  @override
  String get date => '21 JAN - 19 FEV';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone =>
      Image.asset('assets/images/zodiac/icon_aquarius/aquarius.png');

  @override
  String get name => 'Aquário';
}
