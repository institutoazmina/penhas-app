import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

import '../../../core/error/failures.dart';
import '../../../core/managers/modules_sevices.dart';
import '../../authentication/presentation/shared/map_failure_message.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../help_center/domain/usecases/security_mode_action_feature.dart';
import '../domain/states/feed_security_state.dart';
import '../domain/states/feed_state.dart';
import '../domain/usecases/feed_use_cases.dart';

part 'feed_controller.g.dart';

class FeedController extends _FeedControllerBase with _$FeedController {
  FeedController({
    required FeedUseCases useCase,
    required IAppModulesServices modulesServices,
  }) : super(useCase, modulesServices);
}

abstract class _FeedControllerBase with Store, MapFailureMessage {
  _FeedControllerBase(this.useCase, this._modulesServices) {
    _registerDataSource();
    _setupSecurityState();
  }

  final FeedUseCases useCase;
  StreamSubscription? _streamCache;
  final IAppModulesServices _modulesServices;

  @observable
  ObservableFuture<Either<Failure, FeedCache>>? _fetchProgress;

  @observable
  ObservableFuture<Either<Failure, FeedCache>>? _reloadProgress;

  @observable
  FeedState state = const FeedState.initial();

  @observable
  String? errorMessage;

  @observable
  FeedSecurityState securityState = const FeedSecurityState.disable();

  @computed
  PageProgressState get reloadState {
    if (_reloadProgress == null ||
        _reloadProgress!.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _reloadProgress!.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @computed
  PageProgressState get fetchState {
    if (_fetchProgress == null ||
        _fetchProgress!.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _fetchProgress!.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  Future<void> fetchNextPage() async {
    errorMessage = '';
    if (fetchState == PageProgressState.loading) {
      return;
    }

    _fetchProgress = ObservableFuture(useCase.fetchNewestTweet());

    final Either<Failure, FeedCache> response = await _fetchProgress!;
    response.fold(_handleFailure, (_) {
      // a lista é atualizada via stream no _registerDataSource
    });
  }

  @action
  Future<void> fetchOldestPage() async {
    errorMessage = '';
    if (fetchState == PageProgressState.loading) {
      return;
    }

    _fetchProgress = ObservableFuture(useCase.fetchOldestTweet());

    final Either<Failure, FeedCache> response = await _fetchProgress!;

    errorMessage = response.fold(
      mapFailureMessage,
      (_) => null,
    );
  }

  @action
  Future<void> reloadFeed() async {
    errorMessage = '';
    if (reloadState == PageProgressState.loading) {
      return;
    }

    if (state.isError) {
      state = const FeedState.initial();
    }
    _reloadProgress = ObservableFuture(useCase.reloadTweetFeed());

    final Either<Failure, FeedCache> response = await _reloadProgress!;

    response.fold(_handleFailure, (_) {
      // a lista é atualizada via stream no _registerDataSource
    });
  }

  void _handleFailure(Failure failure) {
    final failureMessage = mapFailureMessage(failure);
    if (!state.isInitial) {
      errorMessage = failureMessage;
    } else {
      state = FeedState.error(failureMessage!);
    }
  }

  @action
  void dispose() {
    _cancelDataSource();
  }

  void _registerDataSource() {
    _streamCache = useCase
        .tweetList()
        .listen((cache) => state = FeedState.loaded(cache.tweets));
  }

  Future<void> _setupSecurityState() async {
    securityState =
        await SecurityModeActionFeature(modulesServices: _modulesServices)
                .isEnabled
            ? const FeedSecurityState.enable()
            : const FeedSecurityState.disable();
  }

  void _cancelDataSource() {
    _streamCache?.cancel();
    _streamCache = null;
  }
}
