import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/escape_manual/domain/send_pending_escape_manual_tasks.dart';
import 'package:penhas/app/features/escape_manual/presentation/send_pending_escape_manual_task.dart';

void main() {
  late SendPendingEscapeManualTask sut;

  late SendPendingEscapeManualTasksUseCase mockUseCase;

  setUp(() {
    mockUseCase = _MockSendPendingEscapeManualTasksUseCase();
    sut = SendPendingEscapeManualTask(mockUseCase);
  });

  group(SendPendingEscapeManualTask, () {
    test(
      'execute should return true when use case returns right',
      () async {
        // arrange
        when(() => mockUseCase()).thenAnswer((_) async => const Right(null));

        // act
        final result = await sut.execute();

        // assert
        expect(result, isTrue);
      },
    );

    test(
      'execute should return false when use case returns left',
      () async {
        // arrange
        when(() => mockUseCase())
            .thenAnswer((_) async => Left(ServerFailure()));

        // act
        final result = await sut.execute();

        // assert
        expect(result, isFalse);
      },
    );
  });
}

class _MockSendPendingEscapeManualTasksUseCase extends Mock
    implements SendPendingEscapeManualTasksUseCase {}
