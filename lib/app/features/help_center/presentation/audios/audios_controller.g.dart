// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audios_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AudiosController on _AudiosControllerBase, Store {
  Computed<PageProgressState>? _$loadStateComputed;

  @override
  PageProgressState get loadState => (_$loadStateComputed ??=
          Computed<PageProgressState>(() => super.loadState,
              name: '_AudiosControllerBase.loadState'))
      .value;
  Computed<PageProgressState>? _$updateStateComputed;

  @override
  PageProgressState get updateState => (_$updateStateComputed ??=
          Computed<PageProgressState>(() => super.updateState,
              name: '_AudiosControllerBase.updateState'))
      .value;

  final _$_fetchProgressAtom =
      Atom(name: '_AudiosControllerBase._fetchProgress');

  @override
  ObservableFuture<Either<Failure, List<AudioEntity>?>>? get _fetchProgress {
    _$_fetchProgressAtom.reportRead();
    return super._fetchProgress;
  }

  @override
  set _fetchProgress(
      ObservableFuture<Either<Failure, List<AudioEntity>?>>? value) {
    _$_fetchProgressAtom.reportWrite(value, super._fetchProgress, () {
      super._fetchProgress = value;
    });
  }

  final _$_updateProgressAtom =
      Atom(name: '_AudiosControllerBase._updateProgress');

  @override
  ObservableFuture<Either<Failure, ValidField>>? get _updateProgress {
    _$_updateProgressAtom.reportRead();
    return super._updateProgress;
  }

  @override
  set _updateProgress(ObservableFuture<Either<Failure, ValidField>>? value) {
    _$_updateProgressAtom.reportWrite(value, super._updateProgress, () {
      super._updateProgress = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_AudiosControllerBase.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$currentStateAtom = Atom(name: '_AudiosControllerBase.currentState');

  @override
  AudiosState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(AudiosState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  final _$actionSheetStateAtom =
      Atom(name: '_AudiosControllerBase.actionSheetState');

  @override
  AudioTileAction get actionSheetState {
    _$actionSheetStateAtom.reportRead();
    return super.actionSheetState;
  }

  @override
  set actionSheetState(AudioTileAction value) {
    _$actionSheetStateAtom.reportWrite(value, super.actionSheetState, () {
      super.actionSheetState = value;
    });
  }

  final _$playingAudioStateAtom =
      Atom(name: '_AudiosControllerBase.playingAudioState');

  @override
  AudioPlaying get playingAudioState {
    _$playingAudioStateAtom.reportRead();
    return super.playingAudioState;
  }

  @override
  set playingAudioState(AudioPlaying value) {
    _$playingAudioStateAtom.reportWrite(value, super.playingAudioState, () {
      super.playingAudioState = value;
    });
  }

  final _$loadPageAsyncAction = AsyncAction('_AudiosControllerBase.loadPage');

  @override
  Future<void> loadPage() {
    return _$loadPageAsyncAction.run(() => super.loadPage());
  }

  final _$deleteAsyncAction = AsyncAction('_AudiosControllerBase.delete');

  @override
  Future<void> delete(AudioEntity audio) {
    return _$deleteAsyncAction.run(() => super.delete(audio));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
currentState: ${currentState},
actionSheetState: ${actionSheetState},
playingAudioState: ${playingAudioState},
loadState: ${loadState},
updateState: ${updateState}
    ''';
  }
}
