import 'package:flutter/widgets.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class DesignSystemWidget {
  static BoxDecoration background() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [
          0.1,
          0.34,
          0.61,
          1.0,
        ],
        colors: [
          DesignSystemColors.darkIndigo,
          DesignSystemColors.darkIndigoTwo,
          DesignSystemColors.cobalt,
          DesignSystemColors.twilight,
        ],
      ),
    );
  }
}
