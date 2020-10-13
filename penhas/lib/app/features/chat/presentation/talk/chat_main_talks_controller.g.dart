// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_main_talks_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatMainTalksController on _ChatMainTalksControllerBase, Store {
  final _$_fetchProgressAtom =
      Atom(name: '_ChatMainTalksControllerBase._fetchProgress');

  @override
  ObservableFuture<Either<Failure, ChatChannelAvailableEntity>>
      get _fetchProgress {
    _$_fetchProgressAtom.reportRead();
    return super._fetchProgress;
  }

  @override
  set _fetchProgress(
      ObservableFuture<Either<Failure, ChatChannelAvailableEntity>> value) {
    _$_fetchProgressAtom.reportWrite(value, super._fetchProgress, () {
      super._fetchProgress = value;
    });
  }

  final _$currentStateAtom =
      Atom(name: '_ChatMainTalksControllerBase.currentState');

  @override
  ChatMainTalksState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(ChatMainTalksState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  final _$reloadAsyncAction =
      AsyncAction('_ChatMainTalksControllerBase.reload');

  @override
  Future<void> reload() {
    return _$reloadAsyncAction.run(() => super.reload());
  }

  final _$_ChatMainTalksControllerBaseActionController =
      ActionController(name: '_ChatMainTalksControllerBase');

  @override
  Future<void> openChannel(ChatChannelEntity channel) {
    final _$actionInfo = _$_ChatMainTalksControllerBaseActionController
        .startAction(name: '_ChatMainTalksControllerBase.openChannel');
    try {
      return super.openChannel(channel);
    } finally {
      _$_ChatMainTalksControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentState: ${currentState}
    ''';
  }
}
