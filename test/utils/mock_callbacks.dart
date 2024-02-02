import 'package:mocktail/mocktail.dart';

abstract class VoidCallback {
  void call();
}

class MockVoidCallback extends Mock implements VoidCallback {}

abstract class VoidCallback1<T> {
  void call(T value);
}

class MockVoidCallback1<T> extends Mock implements VoidCallback1<T> {}
