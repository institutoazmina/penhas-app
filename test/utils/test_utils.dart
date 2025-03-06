import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';

import 'local_file_comparator_trashhold.dart';

const _kGoldenTestsThreshold = 0.8 / 100;

Future<void> preparePageTests(FutureOr<void> Function() testMain) async {
  if (goldenFileComparator is LocalFileComparator) {
    final testUrl = (goldenFileComparator as LocalFileComparator).basedir;

    goldenFileComparator = LocalFileComparatorWithThreshold(
      Uri.parse('$testUrl/test.dart'),
      _kGoldenTestsThreshold,
    );
  } else {
    throw Exception(
      'Expected `goldenFileComparator` to be of type `LocalFileComparator`, '
      'but it is of type `${goldenFileComparator.runtimeType}`',
    );
  }
  enableWarnWhenNoObservables = false;
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadAppFonts();

  const isCi = bool.fromEnvironment('isCI');

  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !isCi,
      ),
    ),
    run: () async {
      return testMain();
    },
  );
}

/// A helper function to run a test against a multiple of data.
///
/// It runs the [body] function for each item in the [data].
///
/// The [description] is the name of the group.
///
/// The [data] is a map of items to run the [body] function.
/// The key is the name of the item and the value is the item itself.
///
/// The [body] function is called for each item in the [data].
@isTestGroup
void parameterizedGroup<T>(
  String description,
  Map<String, T> Function() dataProvider,
  void Function(String name, T item) body, {
  dynamic skip,
}) {
  final data = dataProvider();
  assert(data.isNotEmpty, 'data should not be empty');

  group(description, () {
    for (final entry in data.entries) {
      body(entry.key, entry.value);
    }
  }, skip: skip);
}
