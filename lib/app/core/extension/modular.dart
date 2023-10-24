// ignore_for_file: implementation_imports

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/src/core/interfaces/modular_interface.dart';
import 'package:flutter_modular/src/presenters/modular_impl.dart';

extension ModularExt on ModularInterface {
  Iterable<ModularRoute> get widgetRoutes => (Modular as ModularImpl)
      .injectMap
      .entries
      .where((e) => e.value is WidgetModule)
      .expand((e) => e.value.routes);
}
