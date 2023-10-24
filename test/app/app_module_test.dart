import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/storage/cache_storage.dart';
import 'package:penhas/app/core/storage/impl/hive_cache_storage.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

void main() {
  group(AppModule, () {
    setUp(() {
      initModule(
        AppModule(),
      );
    });

    tearDown(() {
      Modular.removeModule(AppModule());
    });

    test(
      'ICacheStorage should be HiveCacheStorage instance',
      () {
        // arrange
        SharedPreferencesStorePlatform.instance =
            InMemorySharedPreferencesStore.empty();
        // act
        final instance = Modular.get<ICacheStorage>();

        // assert
        expect(instance, isA<HiveCacheStorage>());
      },
    );
  });
}
