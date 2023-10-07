import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/error/failures.dart';
import '../../../core/extension/mobx.dart';
import '../../appstate/domain/entities/app_state_entity.dart';
import '../../authentication/presentation/shared/map_failure_message.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../domain/entity/escape_manual.dart';
import '../domain/get_escape_manual.dart';
import '../domain/start_escape_manual.dart';
import 'escape_manual_state.dart';

part 'escape_manual_controller.g.dart';

class EscapeManualController = _EscapeManualControllerBase
    with _$EscapeManualController;

typedef OnEscapeManualReaction = void Function(EscapeManualReaction? reaction);

abstract class _EscapeManualControllerBase with Store, MapFailureMessage {
  _EscapeManualControllerBase({
    required GetEscapeManualUseCase getEscapeManual,
    required StartEscapeManualUseCase startEscapeManual,
  })  : _getEscapeManual = getEscapeManual,
        _startEscapeManual = startEscapeManual;

  @observable
  EscapeManualState state = const EscapeManualState.initial();

  @observable
  EscapeManualReaction? _reaction;

  @computed
  PageProgressState get progressState => _pageProgress.state;

  final GetEscapeManualUseCase _getEscapeManual;
  final StartEscapeManualUseCase _startEscapeManual;

  @observable
  ObservableFuture? _pageProgress;

  late ObservableFuture<Either<Failure, EscapeManualEntity>> _loadProgress;
  late ObservableFuture<Either<Failure, QuizSessionEntity>> _startProgress;

  @action
  Future<void> load() async {
    if (progressState == PageProgressState.loading) return;

    _pageProgress = _loadProgress = ObservableFuture(_getEscapeManual());
    final result = await _loadProgress;

    state = result.fold(_handleLoadFailure, _handleLoadSuccess);
  }

  @action
  Future<void> openAssistant(EscapeManualAssistantActionEntity action) async {
    if (progressState == PageProgressState.loading) return;

    _pageProgress = _startProgress = ObservableFuture(
      _startEscapeManual(action.quizSession),
    );

    final result = await _startProgress;
    result.fold(_handleOpenAssistantFailure, _handleOpenAssistant);
  }

  ReactionDisposer onReaction(OnEscapeManualReaction fn) {
    return reaction((_) => _reaction, fn);
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
          '/quiz',
          arguments: quizSession,
        )
        .then((_) => load());
  }

  void _handleOpenAssistantFailure(Failure failure) {
    var errorMessage = mapFailureMessage(failure);
    _reaction = EscapeManualReaction.showSnackbar(errorMessage);
  }
}
