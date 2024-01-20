import 'dart:async';

import '../../../core/managers/background_task_manager.dart';
import '../domain/send_pending_escape_manual_tasks.dart';
import '../escape_manual_module.dart';

const sendPendingEscapeManualTask = 'SendPendingEscapeManualTask';

@Task(
  name: sendPendingEscapeManualTask,
  dependencies: [
    EscapeManualModule,
  ],
)
class SendPendingEscapeManualTask implements BackgroundTask {
  const SendPendingEscapeManualTask(this._sendPendingTasks);

  final SendPendingEscapeManualTasksUseCase _sendPendingTasks;

  @override
  Future<bool> execute() async {
    final result = await _sendPendingTasks();
    return result.fold((l) => false, (r) => true);
  }
}
