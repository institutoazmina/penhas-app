import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/usecases/block_user_usecase.dart';

class MockUsersRepository extends Mock implements IUsersRepository {}

class MockFeedUseCases extends Mock implements FeedUseCases {}

void main() {
  late BlockUserUseCase sut;

  late IUsersRepository mockRepository;
  late FeedUseCases mockFeedUseCases;

  setUp(() {
    mockRepository = MockUsersRepository();
    mockFeedUseCases = MockFeedUseCases();

    sut = BlockUserUseCase(
      repository: mockRepository,
      feedUseCases: mockFeedUseCases,
    );

    when(() => mockFeedUseCases.reloadTweetFeed())
        .thenAnswer((_) async => right(const FeedCache(tweets: [])));
  });

  group(BlockUserUseCase, () {
    const clientId = '456';

    test(
      'should call block from repository',
      () async {
        // arrange
        const validField = ValidField(message: 'deu bom!');
        when(() => mockRepository.block(clientId))
            .thenAnswer((_) async => right(validField));

        // act
        await sut(clientId);

        // assert
        verify(() => mockRepository.block(clientId)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return ValidField from repository when success',
      () async {
        // arrange
        const validField = ValidField(message: 'deu bom!');
        when(() => mockRepository.block(clientId))
            .thenAnswer((_) async => right(validField));

        // act
        final result = await sut(clientId);

        // assert
        expect(result, right(validField));
      },
    );

    test(
      'should return failure when fails',
      () async {
        // arrange
        final failure = ServerFailure();
        when(() => mockRepository.block(clientId))
            .thenAnswer((_) async => left(failure));

        // act
        final result = await sut(clientId);

        // assert
        expect(result, left(failure));
      },
    );

    test(
      'should call reloadTweetFeed from FeedUseCases when success',
      () async {
        // arrange
        const validField = ValidField(message: 'deu bom!');
        when(() => mockRepository.block(clientId))
            .thenAnswer((_) async => right(validField));

        // act
        await sut(clientId);

        // assert
        verify(() => mockFeedUseCases.reloadTweetFeed()).called(1);
        verifyNoMoreInteractions(mockFeedUseCases);
      },
    );
  });
}
