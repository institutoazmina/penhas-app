import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

class MockLocalStorage extends Mock implements ILocalStorage {}

void main() {
  late String appModuleKey;
  late IAppModulesServices sut;
  final ILocalStorage storage = MockLocalStorage();

  String _convert(List<AppStateModuleEntity> modules) {
    final objects =
        modules.map((e) => {'code': e.code, 'meta': e.meta}).toList();
    return jsonEncode(objects);
  }

  group(AppModulesServices, () {
    setUp(() {
      appModuleKey = 'br.com.penhas.appModules';
      sut = AppModulesServices(storage: storage);
    });
    test(
      'hit the local storage with correct data model',
      () async {
        // arrange
        final modules = [
          const AppStateModuleEntity(code: 'module_1', meta: '{}'),
          const AppStateModuleEntity(code: 'module_2', meta: '{"data":true}'),
        ];
        final jsonString = _convert(modules);
        when(() => storage.put(any(), any())).thenAnswer((_) => Future.value());
        // act
        await sut.save(modules);
        // assert
        verify(() => storage.put(appModuleKey, jsonString)).called(1);
      },
    );

    test(
      'get the module if exist on storage',
      () async {
        // arrange
        const expected = AppStateModuleEntity(
          code: 'module_2',
          meta: '{"data":true}',
        );
        final modules = [
          const AppStateModuleEntity(code: 'module_1', meta: '{}'),
          const AppStateModuleEntity(code: 'module_2', meta: '{"data":true}'),
        ];
        final jsonString = _convert(modules);
        when(() => storage.get(any())).thenAnswer((_) async => jsonString);
        // act
        final received = await sut.feature(name: 'module_2');
        // assert
        expect(received, expected);
      },
    );

    test(
      'received null if module do not exist on storage',
      () async {
        // arrange
        const dynamic expected = null;
        final modules = [
          const AppStateModuleEntity(code: 'module_1', meta: '{}'),
          const AppStateModuleEntity(code: 'module_2', meta: '{"data":true}'),
        ];
        final jsonString = _convert(modules);
        when(() => storage.get(any())).thenAnswer((_) async => jsonString);
        // act
        final received = await sut.feature(name: 'module_20');
        // assert
        expect(received, expected);
      },
    );
  });
}
