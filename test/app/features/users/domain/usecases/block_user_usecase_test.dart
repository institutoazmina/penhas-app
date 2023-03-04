import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/usecases/block_user_usecase.dart';

class MockUsersRepository extends Mock implements IUsersRepository {}

void main() {
  late BlockUserUseCase sut;
  late MockUsersRepository mockRepository;

  setUp(() {
    mockRepository = MockUsersRepository();
    sut = BlockUserUseCase(repository: mockRepository);
  });

  group(BlockUserUseCase, () {
    const clientId = '456';

    test('should call block from repository', () async {
      // arrange
      const validField = ValidField(message: 'deu bom!');
      when(() => mockRepository.block(clientId))
          .thenAnswer((_) async => right(validField));

      // act
      final result = await sut(clientId);

      // assert
      expect(result, right(validField));
      verify(() => mockRepository.block(clientId));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository returns failure', () async {
      // arrange
      final failure = ServerFailure();
      when(() => mockRepository.block(clientId))
          .thenAnswer((_) async => left(failure));

      // act
      final result = await sut(clientId);

      // assert
      expect(result, left(failure));
      verify(() => mockRepository.block(clientId));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
