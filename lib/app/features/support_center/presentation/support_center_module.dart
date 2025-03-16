import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'support_center_controller.dart';
import 'support_center_page.dart';

class SupportCenterModule extends WidgetModule {
  SupportCenterModule({Key? key}) : super(key: key);

  @override
  List<Bind> get binds => [];

  @override
  Widget get view => SupportCenterPage(
        controller: Modular.get<SupportCenterController>(),
      );
}
