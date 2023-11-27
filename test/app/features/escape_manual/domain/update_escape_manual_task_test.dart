import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/repository/escape_manual_repository.dart';
import 'package:penhas/app/features/escape_manual/domain/update_escape_manual_task.dart';

import '../../../../utils/mocktail_extension.dart';

void main() {
  group(UpdateEscapeManualTaskUseCase, () {
    late UpdateEscapeManualTaskUseCase sut;

    late IEscapeManualRepository mockRepository;

    setUpAll(() {
      registerFallbackValue(_FakeEscapeManualTaskEntity());
    });

    setUp(() {
      mockRepository = _MockEscapeManualRepository();

      sut = UpdateEscapeManualTaskUseCase(repository: mockRepository);
    });

    test('should call repository updateTask', () async {
      // arrange
      final task = _FakeEscapeManualTaskEntity();
      when(() => mockRepository.updateTask(any())).thenSuccess((_) => unit);

      // act
      final result = await sut(task);

      // assert
      expect(result, isA<Right>());
      verify(() => mockRepository.updateTask(task)).called(1);
    });
  });
}

class _MockEscapeManualRepository extends Mock
    implements IEscapeManualRepository {}

class _FakeEscapeManualTaskEntity extends Fake
    implements EscapeManualTaskEntity {}
