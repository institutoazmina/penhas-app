import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scroll_to_index/util.dart';

import '../../shared/design_system/animation.dart';

const preserveFromPreviousViewport = 20;

typedef PostFrameCallback = Future Function(Duration timeStamp);

abstract class ScrollOverflowListener {
  SliverGeometry? get renderGeometry;

  void onScrollOverflow();
}

extension ScrollControllerExt on ScrollController {
  void maybeScrollToEnd(
    ScrollOverflowListener listener,
    SliverGeometry? initialGeometry, [
    Duration animationDuration = defaultAnimationDuration,
  ]) {
    _enqueueScroll((_) async {
      final currentScrollExtent = listener.renderGeometry?.scrollExtent ?? 0;
      if (position.maxScrollExtent == 0) return;
      if (currentScrollExtent < position.viewportDimension) return;

      final initialScrollExtent = initialGeometry?.scrollExtent ?? 0;
      var maxExpectedOffset =
          initialScrollExtent - preserveFromPreviousViewport;
      if (maxExpectedOffset > position.maxScrollExtent) {
        maxExpectedOffset = position.maxScrollExtent;
      }

      if (maxExpectedOffset > offset) {
        await animateTo(
          maxExpectedOffset,
          duration: animationDuration,
          curve: Curves.ease,
        );
      } else {
        listener.onScrollOverflow();
      }
    });
  }

  void scrollToEnd([Duration animationDuration = defaultAnimationDuration]) {
    _enqueueScroll((_) async {
      await animateTo(
        position.maxScrollExtent,
        duration: animationDuration,
        curve: Curves.ease,
      );
    });
  }

  void _enqueueScroll(PostFrameCallback action) => co(
        this,
        () async {
          final completer = Completer();

          final addPostFrameCallback =
              WidgetsBinding.instance?.addPostFrameCallback ??
                  (callback) => callback(Duration.zero); // coverage:ignore-line

          addPostFrameCallback((duration) async {
            completer.complete(
              action(duration),
            );
          });

          await completer.future;
        },
      );
}
