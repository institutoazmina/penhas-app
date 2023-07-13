import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/get_escape_manual.dart';
import 'domain/start_escape_manual.dart';
import 'presentation/escape_manual_controller.dart';

class EscapeManualModule extends WidgetModule {
  EscapeManualModule({Key? key}) : super(key: key);

  @override
  Widget get view => Container();

  @override
  final List<Bind<Object>> binds = [
    Bind.factory(
      (i) => EscapeManualController(
        getEscapeManual: i.get(),
        startEscapeManual: i.get(),
      ),
    ),
    Bind.factory(
      (i) => GetEscapeManualUseCase(
        repository: i.get(),
      ),
    ),
    Bind.factory(
      (i) => StartEscapeManualUseCase(
        repository: i.get(),
      ),
    ),
  ];
}
