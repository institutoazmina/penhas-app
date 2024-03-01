import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

extension SliverAnimatedListStateExtension
    on GlobalKey<SliverAnimatedListState> {
  SliverGeometry? get renderGeometry {
    final context = currentContext;
    if (context == null) return null;
    final renderObject = context.findRenderObject();
    if (renderObject is RenderSliver) {
      return renderObject.geometry;
    }
    return null;
  }
}
