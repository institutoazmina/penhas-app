import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/escape_manual/domain/repository/escape_manual_repository.dart';
import 'package:penhas/app/features/escape_manual/domain/send_pending_escape_manual_tasks.dart';

import '../../../../utils/mocktail_extension.dart';

void main() {
  group(SendPendingEscapeManualTasksUseCase, () {
    late SendPendingEscapeManualTasksUseCase sut;

    late IEscapeManualRepository mockRepository;

    setUp(() {
      mockRepository = _MockEscapeManualRepository();

      sut = SendPendingEscapeManualTasksUseCase(repository: mockRepository);
    });

    test(
      'should call repository sendPendingTasks',
      () async {
        // arrange
        when(() => mockRepository.sendPendingTasks()).thenSuccess((_) => unit);

        // act
        final result = await sut();

        // assert
        expect(result, isA<Right>());
        verify(() => mockRepository.sendPendingTasks()).called(1);
      },
    );
  });
}

class _MockEscapeManualRepository extends Mock
    implements IEscapeManualRepository {}
