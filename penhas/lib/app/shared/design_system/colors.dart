import 'dart:ui';

class DesignSystemColors {
  static const ligthPurple = Color.fromRGBO(160, 101, 255, 1);
  static const easterPurple = Color.fromRGBO(159, 99, 255, 1);
  static const darkIndigo = Color.fromRGBO(8, 8, 40, 1);
  static const darkIndigoTwo = Color.fromRGBO(16, 14, 87, 1);
  static const darkIndigoThree = Color.fromRGBO(10, 17, 95, 1);
  static const cobalt = Color.fromRGBO(27, 24, 106, 1);
  static const cobaltTwo = Color.fromRGBO(34, 29, 116, 1);
  static const twilight = Color.fromRGBO(85, 82, 156, 1);
  static const charcoalGrey = Color.fromRGBO(48, 54, 62, 1);
  static const charcoalGrey2 = Color.fromRGBO(68, 74, 83, 1);
  static const blueyGrey = Color.fromRGBO(141, 146, 157, 1);
  static const warnGrey = Color.fromRGBO(129, 129, 129, 1);
  static const brownishGrey = Color.fromRGBO(105, 105, 105, 1);
  static const white = Color.fromRGBO(252, 252, 252, 1);
  static const pinkishGrey = Color.fromRGBO(214, 210, 195, 1);
  static const pinky = Color.fromRGBO(249, 130, 180, 1);
  static const pumpkinOrange = Color.fromRGBO(255, 130, 0, 1);
  static const helpCenterBackGround = Color.fromRGBO(10, 15, 95, 1);
  static const buttonBarIconColor = Color.fromRGBO(10, 17, 96, 1);
  static const helpCenterButtonBar = Color.fromRGBO(34, 29, 116, 1);
  static const helpCenterNavigationBar = Color.fromRGBO(33, 29, 116, 1);
  static const nigthBlue = Color.fromRGBO(5, 8, 70, 1);
  static const bluishPurple = Color.fromRGBO(129, 51, 255, 1);
  static const systemBackgroundColor = Color.fromRGBO(248, 248, 248, 1);
  static Color hexColor(String value) {
    String hexColor = value.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    final foo = Color(int.parse(hexColor, radix: 16));
    return foo;
  }
}
