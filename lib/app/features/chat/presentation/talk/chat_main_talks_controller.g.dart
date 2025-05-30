// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_main_talks_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatMainTalksController on IChatMainTalksController, Store {
  late final _$_fetchProgressAtom =
      Atom(name: 'IChatMainTalksController._fetchProgress', context: context);

  @override
  ObservableFuture<Either<Failure, ChatChannelAvailableEntity>>?
      get _fetchProgress {
    _$_fetchProgressAtom.reportRead();
    return super._fetchProgress;
  }

  @override
  set _fetchProgress(
      ObservableFuture<Either<Failure, ChatChannelAvailableEntity>>? value) {
    _$_fetchProgressAtom.reportWrite(value, super._fetchProgress, () {
      super._fetchProgress = value;
    });
  }

  late final _$currentStateAtom =
      Atom(name: 'IChatMainTalksController.currentState', context: context);

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

  late final _$reloadAsyncAction =
      AsyncAction('IChatMainTalksController.reload', context: context);

  @override
  Future<void> reload() {
    return _$reloadAsyncAction.run(() => super.reload());
  }

  late final _$openChannelAsyncAction =
      AsyncAction('IChatMainTalksController.openChannel', context: context);

  @override
  Future<void> openChannel(ChatChannelEntity channel) {
    return _$openChannelAsyncAction.run(() => super.openChannel(channel));
  }

  late final _$openAssistantCardAsyncAction = AsyncAction(
      'IChatMainTalksController.openAssistantCard',
      context: context);

  @override
  Future<void> openAssistantCard(ChatMainSupportTile data) {
    return _$openAssistantCardAsyncAction
        .run(() => super.openAssistantCard(data));
  }

  @override
  String toString() {
    return '''
currentState: ${currentState}
    ''';
  }
}
