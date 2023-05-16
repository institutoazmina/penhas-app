import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_request.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_usecase_event.dart';
import 'package:penhas/app/features/chat/domain/usecases/chat_channel_usecase.dart';

class MockChatChannelRepository extends Mock implements IChatChannelRepository {
}

void main() {
  late String channelToken;
  late ChatUserEntity chatUserEntity;
  late MockChatChannelRepository mockChatChannelRepository;
  late ChatChannelUseCase chatChannelUseCase;

  setUpAll(() {
    registerFallbackValue(FakeChatChannelRequest());
  });

  setUp(() {
    channelToken = '123';
    chatUserEntity = buildChatUser();
    mockChatChannelRepository = MockChatChannelRepository();
    chatChannelUseCase = ChatChannelUseCase(
      session: ChatChannelOpenEntity(token: channelToken), // fill in as needed
      channelRepository: mockChatChannelRepository,
    );
  });

  tearDown(() {
    chatChannelUseCase.dispose();
  });

  group(ChatChannelUseCase, () {
    group('block method', () {
      test(
        'blocks a channel',
        () async {
          // arrange
          final session = buildChatChannelSession(chatUserEntity);
          final chatChannelRequest = ChatChannelRequest(
            token: channelToken,
            clientId: chatUserEntity.userId.toString(),
            block: true,
          );
          const List<ChatChannelUseCaseEvent> messagesEvent = [
            ChatChannelUseCaseEvent.updateMetadata(
                ChatChannelSessionMetadataEntity(
                    canSendMessage: false,
                    didBlocked: true,
                    headerMessage: '',
                    headerWarning: '',
                    isBlockable: true,
                    lastMessageEtag: 'abcd')),
          ];
          var messagesEventIndex = 0;

          when(() => mockChatChannelRepository.blockChannel(any()))
              .thenAnswer((_) async => right(const ValidField()));
          when(() => mockChatChannelRepository.getMessages(any()))
              .thenAnswer((_) async => right(session));

          // act
          await load(chatChannelUseCase);
          // Testando as mensagens do stream e para isto tenho que escutar o stream
          // antes de executar o método `block`
          chatChannelUseCase.dataSource.listen(
            expectAsync1((event) {
              expect(event, messagesEvent[messagesEventIndex]);
              messagesEventIndex++;
            }, max: -1),
          );

          await chatChannelUseCase.block();

          // assert
          final captured =
              verify(() => mockChatChannelRepository.blockChannel(captureAny()))
                  .captured;
          expect(captured.last, chatChannelRequest);
        },
      );

      // test('handles failure correctly when blocking a channel fails', () async {
      //   // arrange
      //   var failure = Failure(); // fill in as needed
      //   when(() => mockChatChannelRepository.blockChannel(any()))
      //       .thenAnswer((_) async => Left(failure));

      //   // act
      //   await chatChannelUseCase.block();

      //   // assert
      //   verify(() => mockChatChannelRepository.blockChannel(any()));
      //   // You can also add more assertions here to check if the state of the chatChannelUseCase has changed as expected.
      // });
    });

    // test('initializes with correct state', () async {
    //   // Add your expectations and verifications here
    // });

    // test('sentMessage sends a message', () async {
    //   // arrange
    //   when(() => mockChatChannelRepository.sentMessage(any())).thenAnswer(
    //     (_) async => const Right(
    //       ChatSentMessageResponseEntity(
    //         id: 123,
    //         currentMessageEtag: 'efgh',
    //         lastMessageEtag: 'abcd',
    //       ),
    //     ),
    //   ); // fill in as needed
    //   // act
    //   await chatChannelUseCase.sentMessage('Test message');
    //   // assert
    //   verify(() => mockChatChannelRepository.sentMessage(any()));
    //   // dd your expectations and verifications here
    // });

    // Add more tests for all your methods
  });
}

ChatChannelSessionEntity buildChatChannelSession(
    ChatUserEntity chatUserEntity) {
  return ChatChannelSessionEntity(
    hasMore: false,
    messages: const [],
    metadata: const ChatChannelSessionMetadataEntity(
      canSendMessage: true,
      didBlocked: false,
      headerMessage: '',
      headerWarning: '',
      isBlockable: true,
      lastMessageEtag: 'abcd',
    ),
    newer: '',
    older: '',
    user: chatUserEntity,
  );
}

ChatUserEntity buildChatUser({int? userId, String? nickname}) {
  return ChatUserEntity(
    userId: userId ?? 128,
    activity: 'five minutes ago',
    avatar: 'https://api.example.com/avatar/padrao.svg',
    blockedMe: false,
    nickname: nickname ?? 'penhas',
  );
}

Future<void> load(ChatChannelUseCase chatChannel) async {
  // final List<ChatChannelUseCaseEvent> matchers = [
  //   ChatChannelUseCaseEvent.updateUser(chatUserEntity),
  //   ChatChannelUseCaseEvent.updateMetadata(
  //       ChatChannelSessionMetadataEntity(
  //           canSendMessage: true,
  //           didBlocked: false,
  //           headerMessage: '',
  //           headerWarning: '',
  //           isBlockable: true,
  //           lastMessageEtag: 'abcd')),
  //   const ChatChannelUseCaseEvent.loaded(),
  //   ChatChannelUseCaseEvent.updateMessage([]),
  //   ChatChannelUseCaseEvent.updateMetadata(
  //       ChatChannelSessionMetadataEntity(
  //           canSendMessage: false,
  //           didBlocked: true,
  //           headerMessage: '',
  //           headerWarning: '',
  //           isBlockable: true,
  //           lastMessageEtag: 'abcd')),
  // ];
  // var i = 0;

  // chatChannel.dataSource.listen(
  //   expectAsync1((event) {
  //     expect(event, matchers[i]);
  //     i++;
  //   }, max: -1),
  // );
  final StreamSubscription dataSource =
      chatChannel.dataSource.listen((event) {});

  await Future.delayed(const Duration(seconds: 1), () {
    dataSource.cancel();
  });
  return Future.value();
}

class FakeChatChannelRequest extends Fake implements ChatChannelRequest {}
