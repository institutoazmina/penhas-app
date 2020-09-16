import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'izodiac.dart';

class ZodiacSignSagittarius implements IZodiac {
  @override
  Widget get constelation =>
      SvgPicture.asset('assets/images/zodiac/svg/constelation_sagittarius.svg');

  @override
  String get date => '22 NOV - 21 DEZ';

  @override
  List<String> get feeling => throw UnimplementedError();

  @override
  Widget get icone =>
      Image.asset('assets/images/zodiac/icon_sagittarius/sagittarius.png');

  @override
  String get name => 'Sagitário';
}
