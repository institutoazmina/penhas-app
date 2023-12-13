import 'package:collection/collection.dart';

extension IterableExt<T> on Iterable<T> {
  List<T> operator +(Iterable<T> other) => toList() + other.toList();

  Iterable<R> mapNotNull<R>(R? Function(T) transform) sync* {
    for (final element in this) {
      final transformed = element != null ? transform(element) : null;
      if (transformed != null) {
        yield transformed;
      }
    }
  }

  Iterable<MapEntry<int, T>> asMapEntries() sync* {
    var index = 0;
    for (final element in this) {
      yield MapEntry(index, element);
      index++;
    }
  }

  Iterable<T> sortIndexed(
    int Function(MapEntry<int, T> a, MapEntry<int, T> b) compare,
  ) =>
      asMapEntries().sorted(compare).map((e) => e.value);
}
