extension ListExt<T> on List<T> {
  bool removeFirstWhere(bool Function(T) test) =>
      doOnFirst(test, (index, item) {
        removeAt(index);
      });

  bool updateFirstWhere(
    bool Function(T item) test,
    T Function(T item) update,
  ) =>
      doOnFirst(
        test,
        (index, item) => this[index] = update(item),
      );

  bool doOnFirst(
    bool Function(T item) test,
    void Function(int index, T item) action,
  ) {
    for (var index = 0; index < length; index++) {
      var item = this[index];
      if (test(item)) {
        action(index, item);
        return true;
      }
    }
    return false;
  }
}
