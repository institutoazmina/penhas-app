import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/usecases/report_user_usecase.dart';

class MockUsersRepository extends Mock implements IUsersRepository {}

void main() {
  late ReportUserUseCase sut;
  late MockUsersRepository mockRepository;

  setUp(() {
    mockRepository = MockUsersRepository();
    sut = ReportUserUseCase(repository: mockRepository);
  });

  group(ReportUserUseCase, () {
    const clientId = '123';

    test('should call report from repository', () async {
      // arrange
      const validField = ValidField(message: 'deu bom!');
      const reason = 'Inappropriate behavior';
      when(() => mockRepository.report(clientId, reason))
          .thenAnswer((_) async => right(validField));

      // act
      final result = await sut(clientId: clientId, reason: reason);

      // assert
      expect(result, right(validField));
      verify(() => mockRepository.report(clientId, reason));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository returns failure', () async {
      // arrange
      final failure = ServerFailure();
      const reason = 'Inappropriate behavior';
      when(() => mockRepository.report(clientId, reason))
          .thenAnswer((_) async => left(failure));

      // act
      final result = await sut(clientId: clientId, reason: reason);

      // assert
      expect(result, left(failure));
      verify(() => mockRepository.report(clientId, reason));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
