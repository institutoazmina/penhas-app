// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_tweet_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailTweetController on _DetailTweetControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_DetailTweetControllerBase.currentState'))
      .value;

  late final _$_progressAtom =
      Atom(name: '_DetailTweetControllerBase._progress', context: context);

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

  late final _$listTweetsAtom =
      Atom(name: '_DetailTweetControllerBase.listTweets', context: context);

  @override
  ObservableList<TweetEntity> get listTweets {
    _$listTweetsAtom.reportRead();
    return super.listTweets;
  }

  @override
  set listTweets(ObservableList<TweetEntity> value) {
    _$listTweetsAtom.reportWrite(value, super.listTweets, () {
      super.listTweets = value;
    });
  }

  late final _$isAnonymousModeAtom = Atom(
      name: '_DetailTweetControllerBase.isAnonymousMode', context: context);

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
      name: '_DetailTweetControllerBase.isEnableCreateButton',
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

  late final _$editingControllerAtom = Atom(
      name: '_DetailTweetControllerBase.editingController', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_DetailTweetControllerBase.errorMessage', context: context);

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

  late final _$highlightPendingAtom = Atom(
      name: '_DetailTweetControllerBase.highlightPending', context: context);

  @override
  bool get highlightPending {
    _$highlightPendingAtom.reportRead();
    return super.highlightPending;
  }

  @override
  set highlightPending(bool value) {
    _$highlightPendingAtom.reportWrite(value, super.highlightPending, () {
      super.highlightPending = value;
    });
  }

  late final _$getDetailAsyncAction =
      AsyncAction('_DetailTweetControllerBase.getDetail', context: context);

  @override
  Future<void> getDetail() {
    return _$getDetailAsyncAction.run(() => super.getDetail());
  }

  late final _$fetchNextPageAsyncAction =
      AsyncAction('_DetailTweetControllerBase.fetchNextPage', context: context);

  @override
  Future<void> fetchNextPage() {
    return _$fetchNextPageAsyncAction.run(() => super.fetchNextPage());
  }

  @override
  String toString() {
    return '''
listTweets: ${listTweets},
isAnonymousMode: ${isAnonymousMode},
isEnableCreateButton: ${isEnableCreateButton},
editingController: ${editingController},
errorMessage: ${errorMessage},
highlightPending: ${highlightPending},
currentState: ${currentState}
    ''';
  }
}
