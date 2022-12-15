import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

import '../../../utils/helper.mocks.dart';

void main() {
  late AppModulesServices sut;
  late final MockILocalStorage storage = MockILocalStorage();
  String? appModuleKey;

  String _convert(List<AppStateModuleEntity> modules) {
    final objects =
        modules.map((e) => {'code': e.code, 'meta': e.meta}).toList();
    return jsonEncode(objects);
  }

  group('AppModulesServices', () {
    setUp(() {
      appModuleKey = 'br.com.penhas.appModules';
      sut = AppModulesServices(storage: storage);
    });
    test(
        'should hit the local storage with correct id and struct from correct model',
        () async {
      // arrange
      final modules = [
        const AppStateModuleEntity(code: 'module_1', meta: '{}'),
        const AppStateModuleEntity(code: 'module_2', meta: '{"data":true}'),
      ];
      final jsonString = _convert(modules);
      when(storage.put(any, any)).thenAnswer((_) => Future.value());
      // act
      await sut.save(modules);
      // assert
      verify(storage.put(appModuleKey, jsonString));
    });

    test('should get the module if exist on storage', () async {
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
      when(storage.get(any)).thenAnswer((_) => Future.value(jsonString));
      // act
      final received = await sut.feature(name: 'module_2');
      // assert
      expect(received, expected);
    });

    test('should received null if module do not existe on storage', () async {
      // arrange
      const dynamic expected = null;
      final modules = [
        const AppStateModuleEntity(code: 'module_1', meta: '{}'),
        const AppStateModuleEntity(code: 'module_2', meta: '{"data":true}'),
      ];
      final jsonString = _convert(modules);
      when(storage.get(any)).thenAnswer((_) => Future.value(jsonString));
      // act
      final received = await sut.feature(name: 'module_20');
      // assert
      expect(received, expected);
    });
  });
}
