import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasource/escape_manual_datasource.dart';
import 'data/repository/escape_manual_repository.dart';
import 'domain/get_escape_manual.dart';
import 'domain/repository/escape_manual_repository.dart';
import 'domain/start_escape_manual.dart';
import 'presentation/escape_manual_controller.dart';
import 'presentation/escape_manual_page.dart';

class EscapeManualModule extends WidgetModule {
  EscapeManualModule({Key? key}) : super(key: key);

  @override
  Widget get view => const EscapeManualPage();

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
    Bind.factory<IEscapeManualRepository>(
      (i) => EscapeManualRepository(
        datasource: i.get(),
      ),
    ),
    Bind.factory<IEscapeManualDatasource>(
      (i) => EscapeManualDatasource(
        apiProvider: i.get(),
      ),
    ),
  ];
}
