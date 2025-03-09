import 'package:flutter_modular/flutter_modular.dart';

import '../../features/escape_manual/data/datasource/impl/escape_manual_local_datasource.dart';
import '../../features/escape_manual/data/datasource/impl/escape_manual_remote_datasource.dart';
import '../../features/escape_manual/data/datastore/escape_manual_cache_store.dart';
import '../../features/escape_manual/data/datastore/escape_manual_persistent_store.dart';
import '../../features/escape_manual/data/repository/escape_manual_repository.dart';
import '../../features/escape_manual/domain/send_pending_escape_manual_tasks.dart';
import '../../features/escape_manual/presentation/send_pending_escape_manual_task.dart';
import '../network/api_client.dart';
import '../storage/cache_storage.dart';
import '../storage/persistent_storage.dart';
import 'background_task_manager.dart';

class BackgroundTaskRegistry extends IBackgroundTaskRegistry {
  const BackgroundTaskRegistry();

  @override
  TaskDefinition definitionByName(String taskName) {
    if (taskName == sendPendingEscapeManualTask) {
      return TaskDefinition(
        taskProvider: () => SendPendingEscapeManualTask(
          SendPendingEscapeManualTasksUseCase(
              repository: EscapeManualRepository(
            localDatasource: EscapeManualLocalDatasource(
              store: EscapeManualTasksStore(
                storageFactory: Modular.get<IPersistentStorageFactory>(),
              ),
            ),
            remoteDatasource: EscapeManualRemoteDatasource(
              apiProvider: Modular.get<IApiProvider>(),
              cacheStorage: EscapeManualCacheStore(
                storage: Modular.get<ICacheStorage>(),
              ),
            ),
          )),
        ),
      );
    }

    throw UnimplementedError(
      'Task $taskName not implemented',
    );
  }
}
