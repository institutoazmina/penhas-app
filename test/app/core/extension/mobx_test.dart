import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/extension/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';

void main() {
  group('ObservableFutureExt', () {
    test('when observable is not assigned the state should be initial', () {
      // arrange
      ObservableFuture? observable;

      // assert
      expect(observable.state, PageProgressState.initial);
    });

    test('when future is pending the state should be loading', () {
      // arrange
      final observable = ObservableFuture(Completer().future);

      // assert
      expect(observable.state, PageProgressState.loading);
    });

    test('when future is done the state should be loaded', () {
      // arrange
      final observable = ObservableFuture.value('any value');

      // assert
      expect(observable.state, PageProgressState.loaded);
    });

    test('when future has error the state should be initial', () {
      // arrange
      final observable = ObservableFuture.error('an error');

      // assert
      expect(observable.state, PageProgressState.initial);
    });
  });
}
