// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_tweet_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReplyTweetController on _ReplyTweetControllerBase, Store {
  Computed<PageProgressState> _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_ReplyTweetControllerBase.currentState'))
      .value;

  final _$_progressAtom = Atom(name: '_ReplyTweetControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, FeedCache>> get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, FeedCache>> value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  final _$isAnonymousModeAtom =
      Atom(name: '_ReplyTweetControllerBase.isAnonymousMode');

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

  final _$isEnableCreateButtonAtom =
      Atom(name: '_ReplyTweetControllerBase.isEnableCreateButton');

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

  final _$editingControllerAtom =
      Atom(name: '_ReplyTweetControllerBase.editingController');

  @override
  TextEditingController get editingController {
    _$editingControllerAtom.reportRead();
    return super.editingController;
  }

  @override
  set editingController(TextEditingController value) {
    _$editingControllerAtom.reportWrite(value, super.editingController, () {
      super.editingController = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_ReplyTweetControllerBase.errorMessage');

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

  final _$replyTweetPressedAsyncAction =
      AsyncAction('_ReplyTweetControllerBase.replyTweetPressed');

  @override
  Future<void> replyTweetPressed() {
    return _$replyTweetPressedAsyncAction.run(() => super.replyTweetPressed());
  }

  final _$_ReplyTweetControllerBaseActionController =
      ActionController(name: '_ReplyTweetControllerBase');

  @override
  void setTweetContent(String content) {
    final _$actionInfo = _$_ReplyTweetControllerBaseActionController
        .startAction(name: '_ReplyTweetControllerBase.setTweetContent');
    try {
      return super.setTweetContent(content);
    } finally {
      _$_ReplyTweetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAnonymousMode: ${isAnonymousMode},
isEnableCreateButton: ${isEnableCreateButton},
editingController: ${editingController},
errorMessage: ${errorMessage},
currentState: ${currentState}
    ''';
  }
}
