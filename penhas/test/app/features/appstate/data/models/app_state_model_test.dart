import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

import '../repositories/app_state_repository_test.dart';

void main() {
  AppStateModel appStateModel;
  setUp(() {});

  group('AppStateModel', () {
    test('should be a subclass of AppStateEntity', () {
      appStateModel = AppStateModel();
      expect(appStateModel, isA<AppStateEntity>());
    });
  });
}
