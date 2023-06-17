import 'dart:async';

import 'utils/test_utils.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) =>
    preparePageTests(testMain);
