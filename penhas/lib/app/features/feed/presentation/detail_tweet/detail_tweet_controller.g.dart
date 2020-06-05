// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_tweet_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailTweetController on _DetailTweetControllerBase, Store {
  Computed<PageProgressState> _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState))
      .value;

  final _$_progressAtom = Atom(name: '_DetailTweetControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, ValidField>> get _progress {
    _$_progressAtom.context.enforceReadPolicy(_$_progressAtom);
    _$_progressAtom.reportObserved();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, ValidField>> value) {
    _$_progressAtom.context.conditionallyRunInAction(() {
      super._progress = value;
      _$_progressAtom.reportChanged();
    }, _$_progressAtom, name: '${_$_progressAtom.name}_set');
  }

  final _$isAnonymousModeAtom =
      Atom(name: '_DetailTweetControllerBase.isAnonymousMode');

  @override
  bool get isAnonymousMode {
    _$isAnonymousModeAtom.context.enforceReadPolicy(_$isAnonymousModeAtom);
    _$isAnonymousModeAtom.reportObserved();
    return super.isAnonymousMode;
  }

  @override
  set isAnonymousMode(bool value) {
    _$isAnonymousModeAtom.context.conditionallyRunInAction(() {
      super.isAnonymousMode = value;
      _$isAnonymousModeAtom.reportChanged();
    }, _$isAnonymousModeAtom, name: '${_$isAnonymousModeAtom.name}_set');
  }

  final _$isEnableCreateButtonAtom =
      Atom(name: '_DetailTweetControllerBase.isEnableCreateButton');

  @override
  bool get isEnableCreateButton {
    _$isEnableCreateButtonAtom.context
        .enforceReadPolicy(_$isEnableCreateButtonAtom);
    _$isEnableCreateButtonAtom.reportObserved();
    return super.isEnableCreateButton;
  }

  @override
  set isEnableCreateButton(bool value) {
    _$isEnableCreateButtonAtom.context.conditionallyRunInAction(() {
      super.isEnableCreateButton = value;
      _$isEnableCreateButtonAtom.reportChanged();
    }, _$isEnableCreateButtonAtom,
        name: '${_$isEnableCreateButtonAtom.name}_set');
  }

  final _$editingControllerAtom =
      Atom(name: '_DetailTweetControllerBase.editingController');

  @override
  TextEditingController get editingController {
    _$editingControllerAtom.context.enforceReadPolicy(_$editingControllerAtom);
    _$editingControllerAtom.reportObserved();
    return super.editingController;
  }

  @override
  set editingController(TextEditingController value) {
    _$editingControllerAtom.context.conditionallyRunInAction(() {
      super.editingController = value;
      _$editingControllerAtom.reportChanged();
    }, _$editingControllerAtom, name: '${_$editingControllerAtom.name}_set');
  }

  final _$errorMessageAtom =
      Atom(name: '_DetailTweetControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$replyTweetPressedAsyncAction = AsyncAction('replyTweetPressed');

  @override
  Future<void> replyTweetPressed() {
    return _$replyTweetPressedAsyncAction.run(() => super.replyTweetPressed());
  }

  final _$_DetailTweetControllerBaseActionController =
      ActionController(name: '_DetailTweetControllerBase');

  @override
  void setTweetContent(String content) {
    final _$actionInfo =
        _$_DetailTweetControllerBaseActionController.startAction();
    try {
      return super.setTweetContent(content);
    } finally {
      _$_DetailTweetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isAnonymousMode: ${isAnonymousMode.toString()},isEnableCreateButton: ${isEnableCreateButton.toString()},editingController: ${editingController.toString()},errorMessage: ${errorMessage.toString()},currentState: ${currentState.toString()}';
    return '{$string}';
  }
}
