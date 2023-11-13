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
}
