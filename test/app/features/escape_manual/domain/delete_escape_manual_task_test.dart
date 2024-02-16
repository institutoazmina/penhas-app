import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/escape_manual/domain/delete_escape_manual_task.dart';
import 'package:penhas/app/features/escape_manual/domain/entity/escape_manual.dart';
import 'package:penhas/app/features/escape_manual/domain/repository/escape_manual_repository.dart';

import '../../../../utils/mocktail_extension.dart';

void main() {
  group(DeleteEscapeManualTaskUseCase, () {
    late DeleteEscapeManualTaskUseCase sut;

    late IEscapeManualRepository mockRepository;

    setUpAll(() {
      registerFallbackValue(_FakeEscapeManualTaskEntity());
    });

    setUp(() {
      mockRepository = _MockEscapeManualRepository();

      sut = DeleteEscapeManualTaskUseCase(repository: mockRepository);
    });

    test('should call repository removeTask', () async {
      // arrange
      final task = _FakeEscapeManualTaskEntity();
      when(() => mockRepository.removeTask(any())).thenSuccess((_) => unit);

      // act
      final result = await sut(task);

      // assert
      expect(result, isA<Right>());
      verify(() => mockRepository.removeTask(task)).called(1);
    });
  });
}

class _MockEscapeManualRepository extends Mock
    implements IEscapeManualRepository {}

class _FakeEscapeManualTaskEntity extends Fake
    implements EscapeManualTodoTaskEntity {}
