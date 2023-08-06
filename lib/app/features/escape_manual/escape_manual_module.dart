import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/managers/app_configuration.dart';
import 'data/datasource/escape_manual_datasource.dart';
import 'data/datasource/impl/escape_manual_local_datasource.dart';
import 'data/datasource/impl/escape_manual_remote_datasource.dart';
import 'data/repository/escape_manual_repository.dart';
import 'domain/delete_escape_manual_task.dart';
import 'domain/get_escape_manual.dart';
import 'domain/repository/escape_manual_repository.dart';
import 'domain/start_escape_manual.dart';
import 'domain/update_escape_manual_task.dart';
import 'presentation/escape_manual_controller.dart';
import 'presentation/escape_manual_page.dart';

class EscapeManualModule extends WidgetModule {
  EscapeManualModule({Key? key}) : super(key: key);

  @override
  Widget get view => const EscapeManualPage();

  @override
  final List<Bind<Object>> binds = [
    Bind.singleton(
      (i) => EscapeManualController(
        getEscapeManual: i.get(),
        startEscapeManual: i.get(),
        updateTask: i.get(),
        deleteTask: i.get(),
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
    Bind.factory(
      (i) => DeleteEscapeManualTaskUseCase(
        repository: i.get(),
      ),
    ),
    Bind.factory(
      (i) => UpdateEscapeManualTaskUseCase(
        repository: i.get(),
      ),
    ),
    Bind.factory<IEscapeManualRepository>(
      (i) => EscapeManualRepository(
        remoteDatasource: i.get(),
        localDatasource: i.get(),
      ),
    ),
    Bind.factory<IEscapeManualLocalDatasource>(
      (i) => EscapeManualLocalDatasource(
        dbProvider: i.get(),
        appConfiguration: i.get<IAppConfiguration>(),
      ),
    ),
    Bind.factory<IEscapeManualRemoteDatasource>(
      (i) => EscapeManualRemoteDatasource(
        apiProvider: i.get(),
      ),
    ),
  ];
}
