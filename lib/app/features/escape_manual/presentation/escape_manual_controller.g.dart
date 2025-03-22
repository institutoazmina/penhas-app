// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escape_manual_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EscapeManualController on EscapeManualControllerBase, Store {
  Computed<PageProgressState>? _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: 'EscapeManualControllerBase.progressState'))
      .value;

  late final _$stateAtom =
      Atom(name: 'EscapeManualControllerBase.state', context: context);

  @override
  EscapeManualState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(EscapeManualState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_reactionAtom =
      Atom(name: 'EscapeManualControllerBase._reaction', context: context);

  @override
  EscapeManualReaction? get _reaction {
    _$_reactionAtom.reportRead();
    return super._reaction;
  }

  @override
  set _reaction(EscapeManualReaction? value) {
    _$_reactionAtom.reportWrite(value, super._reaction, () {
      super._reaction = value;
    });
  }

  late final _$_pageProgressAtom =
      Atom(name: 'EscapeManualControllerBase._pageProgress', context: context);

  @override
  ObservableFuture<dynamic>? get _pageProgress {
    _$_pageProgressAtom.reportRead();
    return super._pageProgress;
  }

  @override
  set _pageProgress(ObservableFuture<dynamic>? value) {
    _$_pageProgressAtom.reportWrite(value, super._pageProgress, () {
      super._pageProgress = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('EscapeManualControllerBase.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$openAssistantAsyncAction =
      AsyncAction('EscapeManualControllerBase.openAssistant', context: context);

  @override
  Future<void> openAssistant(EscapeManualAssistantActionEntity action) {
    return _$openAssistantAsyncAction.run(() => super.openAssistant(action));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('EscapeManualControllerBase.updateTask', context: context);

  @override
  Future<void> updateTask(EscapeManualTodoTaskEntity task) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(task));
  }

  late final _$deleteTaskAsyncAction =
      AsyncAction('EscapeManualControllerBase.deleteTask', context: context);

  @override
  Future<void> deleteTask(EscapeManualTodoTaskEntity task) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(task));
  }

  @override
  String toString() {
    return '''
state: ${state},
progressState: ${progressState}
    ''';
  }
}
