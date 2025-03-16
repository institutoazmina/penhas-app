import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/managers/background_task_manager.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/cache_storage.dart';
import '../../core/storage/persistent_storage.dart';
import 'data/datasource/impl/escape_manual_local_datasource.dart';
import 'data/datasource/impl/escape_manual_remote_datasource.dart';
import 'data/datastore/escape_manual_cache_store.dart';
import 'data/datastore/escape_manual_persistent_store.dart';
import 'data/repository/escape_manual_repository.dart';
import 'domain/delete_escape_manual_task.dart';
import 'domain/escape_manual_toggle.dart';
import 'domain/get_escape_manual.dart';
import 'domain/send_pending_escape_manual_tasks.dart';
import 'domain/start_escape_manual.dart';
import 'domain/update_escape_manual_task.dart';
import 'presentation/edit/edit_trusted_contacts_controller.dart';
import 'presentation/edit/edit_trusted_contacts_page.dart';
import 'presentation/escape_manual_controller.dart';
import 'presentation/escape_manual_page.dart';

class EscapeManualModule extends WidgetModule {
  EscapeManualModule({Key? key}) : super(key: key);

  @override
  Widget get view => EscapeManualPage(
        controller: EscapeManualController(
            backgroundTaskManager: Modular.get<IBackgroundTaskManager>(),
            deleteTask: DeleteEscapeManualTaskUseCase(
                repository: EscapeManualRepository(
                    localDatasource: EscapeManualLocalDatasource(
                        store: EscapeManualTasksStore(
                            storageFactory:
                                Modular.get<IPersistentStorageFactory>())),
                    remoteDatasource: EscapeManualRemoteDatasource(
                        apiProvider: Modular.get<IApiProvider>(),
                        cacheStorage: EscapeManualCacheStore(
                            storage: Modular.get<ICacheStorage>())))),
            getEscapeManual: GetEscapeManualUseCase(
                repository: EscapeManualRepository(
                    localDatasource: EscapeManualLocalDatasource(
                        store: EscapeManualTasksStore(
                            storageFactory:
                                Modular.get<IPersistentStorageFactory>())),
                    remoteDatasource: EscapeManualRemoteDatasource(
                        apiProvider: Modular.get<IApiProvider>(),
                        cacheStorage: EscapeManualCacheStore(
                            storage: Modular.get<ICacheStorage>())))),
            startEscapeManual: StartEscapeManualUseCase(
                repository: EscapeManualRepository(
                    localDatasource: EscapeManualLocalDatasource(
                        store: EscapeManualTasksStore(storageFactory: Modular.get<IPersistentStorageFactory>())),
                    remoteDatasource: EscapeManualRemoteDatasource(apiProvider: Modular.get<IApiProvider>(), cacheStorage: EscapeManualCacheStore(storage: Modular.get<ICacheStorage>())))),
            updateTask: UpdateEscapeManualTaskUseCase(repository: EscapeManualRepository(localDatasource: EscapeManualLocalDatasource(store: EscapeManualTasksStore(storageFactory: Modular.get<IPersistentStorageFactory>())), remoteDatasource: EscapeManualRemoteDatasource(apiProvider: Modular.get<IApiProvider>(), cacheStorage: EscapeManualCacheStore(storage: Modular.get<ICacheStorage>()))))),
      );

  @override
  // ignore: override_on_non_overriding_member
  List<ModularRoute> get routes => [
        ChildRoute(
          '/edit/trusted_contacts',
          child: (_, __) => EditTrustedContactsPage(
            controller: Modular.get<EditTrustedContactsController>(),
          ),
        )
      ];

  @override
  final List<Bind<Object>> binds = [
    Bind.lazySingleton(
      (i) => EscapeManualController(
        getEscapeManual: i.get(),
        startEscapeManual: i.get(),
        updateTask: i.get(),
        deleteTask: i.get(),
        backgroundTaskManager: i.get(),
      ),
    ),
    Bind.factory(
      (i) => EditTrustedContactsController(
        contacts: i.args.data,
        escapeManualToggleFeature: EscapeManualToggleFeature(
          modulesServices: i.get(),
        ),
      ),
    ),
    Bind.factory<GetEscapeManualUseCase>(
      (i) => GetEscapeManualUseCase(
        repository: i.get(),
      ),
    ),
    Bind.factory(
      (i) => StartEscapeManualUseCase(
        repository: i.get(),
      ),
    ),
    Bind.factory<UpdateEscapeManualTaskUseCase>(
      (i) => UpdateEscapeManualTaskUseCase(
        repository: i.get(),
      ),
    ),
    Bind.factory<DeleteEscapeManualTaskUseCase>(
      (i) => DeleteEscapeManualTaskUseCase(
        repository: i.get(),
      ),
    ),
    Bind.factory<SendPendingEscapeManualTasksUseCase>(
      (i) => SendPendingEscapeManualTasksUseCase(
        repository: i.get(),
      ),
    ),
    Bind.factory<IEscapeManualRepository>(
      (i) => EscapeManualRepository(
        localDatasource: i.get(),
        remoteDatasource: i.get(),
      ),
    ),
    Bind.factory<IEscapeManualRemoteDatasource>(
      (i) => EscapeManualRemoteDatasource(
        apiProvider: i.get(),
        cacheStorage: EscapeManualCacheStore(
          storage: i.get(),
        ),
      ),
    ),
    Bind.factory<IEscapeManualLocalDatasource>(
      (i) => EscapeManualLocalDatasource(
        store: EscapeManualTasksStore(
          storageFactory: i.get(),
        ),
      ),
    ),
  ];
}
