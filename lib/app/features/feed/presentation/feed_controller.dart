import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import '../../../core/entities/failure_or.dart';
import '../../../core/error/failures.dart';
import '../../../core/extension/mobx.dart';
import '../../authentication/presentation/shared/map_failure_message.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../help_center/domain/usecases/security_mode_action_feature.dart';
import '../domain/states/feed_security_state.dart';
import '../domain/states/feed_state.dart';
import '../domain/usecases/feed_use_cases.dart';

part 'feed_controller.g.dart';

typedef TFeed = FailureOr<FeedCache>;
typedef _FetchSource = Future<TFeed> Function();

class FeedController = _FeedControllerBase with _$FeedController;

abstract class _FeedControllerBase with Store, MapFailureMessage {
  _FeedControllerBase({
    required FeedUseCases useCase,
    required SecurityModeActionFeature securityModeActionFeature,
  })  : _useCase = useCase,
        _securityModeActionFeature = securityModeActionFeature {
    _registerDataSource();
    _setupSecurityState();
  }

  final FeedUseCases _useCase;
  final SecurityModeActionFeature _securityModeActionFeature;

  @observable
  FeedState state = const FeedState.initial();

  @observable
  FeedSecurityState securityState = const FeedSecurityState.disable();

  @computed
  PageProgressState get fetchState => _fetchProgress.state;

  @computed
  PageProgressState get reloadState => _reloadProgress.state;

  @observable
  String? errorMessage;

  @observable
  ObservableFuture<TFeed>? _fetchProgress;

  @observable
  ObservableFuture<TFeed>? _reloadProgress;

  StreamSubscription? _streamCache;

  @action
  Future<void> fetchNextPage() => _fetch(_useCase.fetchNewestTweet);

  @action
  Future<void> fetchOldestPage() => _fetch(_useCase.fetchOldestTweet);

  @action
  Future<void> reloadFeed() async {
    errorMessage = '';
    if (reloadState == PageProgressState.loading) {
      return;
    }

    _reloadProgress = ObservableFuture(_useCase.reloadTweetFeed());

    final response = await _reloadProgress!;

    response.fold(_handleFailure, (_) {
      // a lista é atualizada via stream no _registerDataSource
    });
  }

  @action
  Future<void> dispose() async {
    await _streamCache?.cancel();
    _streamCache = null;
  }

  Future<void> _fetch(_FetchSource source) async {
    errorMessage = '';
    if (fetchState == PageProgressState.loading) {
      return;
    }
    if (state.isEmpty) {
      state = const FeedState.initial();
    }

    _fetchProgress = ObservableFuture(source());

    final response = await _fetchProgress!;
    response.fold(_handleFailure, (_) {
      // a lista é atualizada via stream no _registerDataSource
    });
  }

  void _handleFailure(Failure failure) {
    final failureMessage = mapFailureMessage(failure);

    if (state.isEmpty) {
      state = FeedState.error(failureMessage!);
    } else {
      errorMessage = failureMessage;
    }
  }

  void _registerDataSource() {
    _streamCache = _useCase
        .tweetList()
        .listen((cache) => state = FeedState.loaded(cache.tweets));

    fetchNextPage();
  }

  Future<void> _setupSecurityState() async {
    securityState = await _securityModeActionFeature.isEnabled
        ? const FeedSecurityState.enable()
        : const FeedSecurityState.disable();
  }
}
