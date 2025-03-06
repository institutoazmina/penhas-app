// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_start_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuizStartController on _QuizStartControllerBase, Store {
  Computed<PageProgressState>? _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_QuizStartControllerBase.progressState'))
      .value;

  late final _$stateAtom =
      Atom(name: '_QuizStartControllerBase.state', context: context);

  @override
  QuizStartState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(QuizStartState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_pageProgressAtom =
      Atom(name: '_QuizStartControllerBase._pageProgress', context: context);

  @override
  ObservableFuture<Either<Failure, QuizSessionEntity>>? get _pageProgress {
    _$_pageProgressAtom.reportRead();
    return super._pageProgress;
  }

  @override
  set _pageProgress(
      ObservableFuture<Either<Failure, QuizSessionEntity>>? value) {
    _$_pageProgressAtom.reportWrite(value, super._pageProgress, () {
      super._pageProgress = value;
    });
  }

  @override
  String toString() {
    return '''
state: ${state},
progressState: ${progressState}
    ''';
  }
}
