import 'dart:async';

extension CompleterExt<T> on Completer<T> {
  Future<void> completeAndWait(T value) async {
    complete(value);
    await future;
  }
}
