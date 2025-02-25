import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/usecases/get_chat_channel_token_usecase.dart';

class MockChatChannelRepository extends Mock
    implements IChatChannelRepository {}

void main() {
  late GetChatChannelTokenUseCase sut;
  late MockChatChannelRepository mockRepository;

  setUp(() {
    mockRepository = MockChatChannelRepository();
    sut = GetChatChannelTokenUseCase(repository: mockRepository);
  });

  group(GetChatChannelTokenUseCase, () {
    const clientId = 123;

    test('should get token from repository', () async {
      // arrange
      const chat = ChatChannelOpenEntity(token: 'token');
      when(() => mockRepository.openChannel(any()))
          .thenAnswer((_) async => right(chat));

      // act
      final result = await sut(clientId);

      // assert
      expect(result, right(chat));
      verify(() => mockRepository.openChannel(clientId.toString()));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository returns failure', () async {
      // arrange
      final failure = ServerFailure();
      when(() => mockRepository.openChannel(any()))
          .thenAnswer((_) async => left(failure));

      // act
      final result = await sut(clientId);

      // assert
      expect(result, left(failure));
      verify(() => mockRepository.openChannel(clientId.toString()));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
