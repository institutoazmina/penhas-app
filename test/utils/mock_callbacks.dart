import 'package:mocktail/mocktail.dart';

abstract class VoidCallback {
  void call();
}

class MockVoidCallback extends Mock implements VoidCallback {}
