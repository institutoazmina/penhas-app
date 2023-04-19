import 'package:mobx/mobx.dart';

import '../../features/authentication/presentation/shared/page_progress_indicator.dart';

extension ObservableFutureExt on ObservableFuture? {
  PageProgressState get state {
    switch (this?.status) {
      case FutureStatus.fulfilled:
        return PageProgressState.loaded;
      case FutureStatus.pending:
        return PageProgressState.loading;
      default:
        return PageProgressState.initial;
    }
  }
}
