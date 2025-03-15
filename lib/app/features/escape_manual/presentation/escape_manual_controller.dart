import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/error/failures.dart';
import '../../../core/extension/either.dart';
import '../../../core/extension/mobx.dart';
import '../../../core/managers/background_task_manager.dart';
import '../../../shared/logger/log.dart';
import '../../appstate/domain/entities/app_state_entity.dart';
import '../../authentication/presentation/shared/map_failure_message.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../domain/delete_escape_manual_task.dart';
import '../domain/entity/escape_manual.dart';
import '../domain/get_escape_manual.dart';
import '../domain/start_escape_manual.dart';
import '../domain/update_escape_manual_task.dart';
import 'escape_manual_state.dart';
import 'send_pending_escape_manual_task.dart';

part 'escape_manual_controller.g.dart';

class EscapeManualController = EscapeManualControllerBase
    with _$EscapeManualController;

typedef OnEscapeManualReaction = void Function(EscapeManualReaction? reaction);

abstract class EscapeManualControllerBase with Store, MapFailureMessage {
  EscapeManualControllerBase({
    required GetEscapeManualUseCase getEscapeManual,
    required StartEscapeManualUseCase startEscapeManual,
    required UpdateEscapeManualTaskUseCase updateTask,
    required DeleteEscapeManualTaskUseCase deleteTask,
    required IBackgroundTaskManager backgroundTaskManager,
  })  : _getEscapeManual = getEscapeManual,
        _startEscapeManual = startEscapeManual,
        _updateTask = updateTask,
        _deleteTask = deleteTask,
        _backgroundTaskManager = backgroundTaskManager;

  @observable
  EscapeManualState state = const EscapeManualState.initial();

  @observable
  EscapeManualReaction? _reaction;

  @computed
  PageProgressState get progressState => _pageProgress.state;

  final GetEscapeManualUseCase _getEscapeManual;
  final StartEscapeManualUseCase _startEscapeManual;
  final UpdateEscapeManualTaskUseCase _updateTask;
  final DeleteEscapeManualTaskUseCase _deleteTask;
  final IBackgroundTaskManager _backgroundTaskManager;

  @observable
  ObservableFuture? _pageProgress;

  @visibleForTesting
  StreamSubscription? subscription;

  ObservableStream<EscapeManualEntity>? _loadProgress;
  late ObservableFuture<Either<Failure, QuizSessionEntity>> _startProgress;

  @action
  Future<void> load() async {
    if (progressState == PageProgressState.loading ||
        _loadProgress.state == PageProgressState.loading) return;

    subscription?.cancel();

    _loadProgress = ObservableStream(
      _getEscapeManual(),
      cancelOnError: true,
    ).asBroadcastStream();

    _pageProgress = _loadProgress?.first;

    subscription = _loadProgress?.listen(
      (el) => state = _handleLoadSuccess(el),
      onError: (e) => state = _handleLoadFailure(e),
      cancelOnError: true,
    );
  }

  @action
  Future<void> openAssistant(EscapeManualAssistantActionEntity action) async {
    if (progressState == PageProgressState.loading) return;

    _pageProgress = _startProgress = ObservableFuture(
      _startEscapeManual(action.quizSession),
    );

    final result = await _startProgress;
    result.fold(_handleErrorAsReaction, _handleOpenAssistant);
  }

  @action
  Future<void> updateTask(EscapeManualTodoTaskEntity task) async {
    final result = await _updateTask(task);
    result.fold(_onSaveTaskFailed, (_) {});
  }

  @action
  Future<void> deleteTask(EscapeManualTodoTaskEntity task) async {
    final result = await _deleteTask(task);
    result.fold(_onSaveTaskFailed, (_) {});
  }

  Future<void> editTask(EscapeManualEditableTaskEntity task) async {
    final newValue = await Modular.to.pushNamed<List<ContactEntity>>(
      '/edit/trusted_contacts',
      arguments: task.value,
    );

    if (newValue != null &&
        !listEquals(newValue, task.value as List<ContactEntity>?)) {
      final updated = task.copyWith(value: newValue);
      await updateTask(updated);
    }
  }

  Future<void> onButtonPressed(ButtonEntity button) async {
    final result = await Modular.to
        .pushNamed(button.route, arguments: button.arguments)
        .toEither();

    result.fold(
      _handleErrorAsReaction,
      (_) => load(),
    );
  }

  void callTo(ContactEntity contact) {
    launchUrlString('tel:${contact.phone}');
  }

  ReactionDisposer onReaction(OnEscapeManualReaction fn) =>
      reaction<EscapeManualReaction?>(
        (_) => _reaction,
        fn,
        equals: (_, __) => false,
      );

  Future<void> dispose() async {
    await subscription?.cancel();
    _loadProgress?.close();
    subscription = null;
  }

  EscapeManualState _handleLoadFailure(Failure failure) {
    var errorMessage = mapFailureMessage(failure);
    return EscapeManualState.error(errorMessage);
  }

  EscapeManualState _handleLoadSuccess(EscapeManualEntity data) {
    return EscapeManualState.loaded(data);
  }

  void _handleOpenAssistant(QuizSessionEntity quizSession) {
    Modular.to
        .pushNamed(
          '/quiz?origin=escape-manual',
          arguments: quizSession,
        )
        .then((_) => load());
  }

  void _handleErrorAsReaction(failure) {
    final errorMessage = mapFailureMessage(failure);
    _reaction = EscapeManualReaction.showSnackBar(errorMessage);
  }

  void _onSaveTaskFailed(e) {
    logError(e);
    _backgroundTaskManager.schedule(sendPendingEscapeManualTask);
  }
}
