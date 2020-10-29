import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'support_center_page.dart';
import 'support_center_controller.dart';

class SupportCenterModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SupportCenterController()),
      ];

  @override
  Widget get view => SupportCenterPage();

  static Inject get to => Inject<SupportCenterModule>.of();
}
