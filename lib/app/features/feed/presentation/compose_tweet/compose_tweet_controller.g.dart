// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compose_tweet_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ComposeTweetController on _ComposeTweetControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_ComposeTweetControllerBase.currentState'))
      .value;

  late final _$_progressAtom =
      Atom(name: '_ComposeTweetControllerBase._progress', context: context);

  @override
  ObservableFuture<Either<Failure, FeedCache>>? get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, FeedCache>>? value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  late final _$isAnonymousModeAtom = Atom(
      name: '_ComposeTweetControllerBase.isAnonymousMode', context: context);

  @override
  bool get isAnonymousMode {
    _$isAnonymousModeAtom.reportRead();
    return super.isAnonymousMode;
  }

  @override
  set isAnonymousMode(bool value) {
    _$isAnonymousModeAtom.reportWrite(value, super.isAnonymousMode, () {
      super.isAnonymousMode = value;
    });
  }

  late final _$isEnableCreateButtonAtom = Atom(
      name: '_ComposeTweetControllerBase.isEnableCreateButton',
      context: context);

  @override
  bool get isEnableCreateButton {
    _$isEnableCreateButtonAtom.reportRead();
    return super.isEnableCreateButton;
  }

  @override
  set isEnableCreateButton(bool value) {
    _$isEnableCreateButtonAtom.reportWrite(value, super.isEnableCreateButton,
        () {
      super.isEnableCreateButton = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_ComposeTweetControllerBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$createTweetPressedAsyncAction = AsyncAction(
      '_ComposeTweetControllerBase.createTweetPressed',
      context: context);

  @override
  Future<void> createTweetPressed([BuildContext? context]) {
    return _$createTweetPressedAsyncAction
        .run(() => super.createTweetPressed(context));
  }

  late final _$_ComposeTweetControllerBaseActionController =
      ActionController(name: '_ComposeTweetControllerBase', context: context);

  @override
  void setTweetContent(String content) {
    final _$actionInfo = _$_ComposeTweetControllerBaseActionController
        .startAction(name: '_ComposeTweetControllerBase.setTweetContent');
    try {
      return super.setTweetContent(content);
    } finally {
      _$_ComposeTweetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAnonymousMode: ${isAnonymousMode},
isEnableCreateButton: ${isEnableCreateButton},
errorMessage: ${errorMessage},
currentState: ${currentState}
    ''';
  }
}
