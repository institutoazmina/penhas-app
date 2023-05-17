// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_request.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_sent_message_response_entity.dart';
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

          await load(
            chatChannelUseCase,
            user: chatUserEntity,
            repository: mockChatChannelRepository,
          );
          // act
          // Testando as mensagens do stream e para isto tenho que escutar o stream
          // antes de executar o método `block`.
          // Se ocorrer algum alteração no stream, o teste falhará
          chatChannelUseCase.dataSource.listen(
            expectAsync1((event) {
              expect(event, messagesEvent[messagesEventIndex]);
              messagesEventIndex++;
            }, max: messagesEvent.length),
          );

          await chatChannelUseCase.block();

          // assert
          final captured =
              verify(() => mockChatChannelRepository.blockChannel(captureAny()))
                  .captured;
          expect(captured.last, chatChannelRequest);
        },
        timeout: const Timeout(Duration(seconds: 2)),
      );

      test('handles failure correctly when blocking a channel fails', () async {
        // arrange
        var failure = InternetConnectionFailure(); // fill in as needed
        when(() => mockChatChannelRepository.blockChannel(any()))
            .thenAnswer((_) async => Left(failure));
        await load(
          chatChannelUseCase,
          user: chatUserEntity,
          repository: mockChatChannelRepository,
        );
        // act
        // Testando as mensagens do stream e para isto tenho que escutar o stream
        // antes de executar o método `block`.
        // Não quero que o stream emita evento, por isso o `count: 0, max: 0`.
        chatChannelUseCase.dataSource.listen(
          expectAsync1((event) {}, count: 0, max: 0),
        );

        await chatChannelUseCase.block();

        // assert
        verify(() => mockChatChannelRepository.blockChannel(any()));
      });
    });

    group('unblock method', () {
      test(
        'unblock a channel',
        () async {
          // arrange
          final chatChannelRequest = ChatChannelRequest(
            token: channelToken,
            clientId: chatUserEntity.userId.toString(),
            block: false,
          );
          const List<ChatChannelUseCaseEvent> messagesEvent = [
            ChatChannelUseCaseEvent.updateMetadata(
                ChatChannelSessionMetadataEntity(
                    canSendMessage: true,
                    didBlocked: false,
                    headerMessage: '',
                    headerWarning: '',
                    isBlockable: true,
                    lastMessageEtag: 'abcd')),
          ];
          var messagesEventIndex = 0;

          when(() => mockChatChannelRepository.blockChannel(any()))
              .thenAnswer((_) async => right(const ValidField()));

          await load(
            chatChannelUseCase,
            user: chatUserEntity,
            repository: mockChatChannelRepository,
          );
          // act
          // Testando as mensagens do stream e para isto tenho que escutar o stream
          // antes de executar o método `block`.
          // Se ocorrer algum alteração no stream, o teste falhará
          chatChannelUseCase.dataSource.listen(
            expectAsync1((event) {
              expect(event, messagesEvent[messagesEventIndex]);
              messagesEventIndex++;
            }, max: messagesEvent.length),
          );

          await chatChannelUseCase.unblock();

          // assert
          final captured =
              verify(() => mockChatChannelRepository.blockChannel(captureAny()))
                  .captured;
          expect(captured.last, chatChannelRequest);
        },
        timeout: const Timeout(Duration(seconds: 2)),
      );

      test('handles failure correctly when unblocking a channel fails',
          () async {
        // arrange
        var failure = InternetConnectionFailure(); // fill in as needed
        when(() => mockChatChannelRepository.blockChannel(any()))
            .thenAnswer((_) async => Left(failure));
        await load(
          chatChannelUseCase,
          user: chatUserEntity,
          repository: mockChatChannelRepository,
        );
        // act
        // Testando as mensagens do stream e para isto tenho que escutar o stream
        // antes de executar o método `block`.
        // Não quero que o stream emita evento, por isso o `count: 0, max: 0`.
        chatChannelUseCase.dataSource.listen(
          expectAsync1((event) {}, count: 0, max: 0),
        );

        await chatChannelUseCase.unblock();

        // assert
        verify(() => mockChatChannelRepository.blockChannel(any()));
      });
    });

    group('delete method', () {
      test(
        'delete a channel',
        () async {
          // arrange
          final session = buildChatChannelSession(chatUserEntity);
          final chatChannelRequest = ChatChannelRequest(token: channelToken);
          List<ChatChannelUseCaseEvent> messagesEvent = [
            ChatChannelUseCaseEvent.updateMessage([]),
            ChatChannelUseCaseEvent.updateUser(chatUserEntity),
            ChatChannelUseCaseEvent.updateMetadata(
                ChatChannelSessionMetadataEntity(
                    canSendMessage: true,
                    didBlocked: false,
                    headerMessage: '',
                    headerWarning: '',
                    isBlockable: true,
                    lastMessageEtag: 'abcd')),
            ChatChannelUseCaseEvent.loaded()
          ];
          var messagesEventIndex = 0;

          when(() => mockChatChannelRepository.deleteChannel(any()))
              .thenAnswer((_) async => right(const ValidField()));
          when(() => mockChatChannelRepository.getMessages(any()))
              .thenAnswer((_) async => right(session));

          await load(
            chatChannelUseCase,
            user: chatUserEntity,
            repository: mockChatChannelRepository,
          );
          // act
          // Testando as mensagens do stream e para isto tenho que escutar o stream
          // antes de executar o método `block`.
          // Se ocorrer algum alteração no stream, o teste falhará
          chatChannelUseCase.dataSource.listen(
            expectAsync1((event) {
              expect(event, messagesEvent[messagesEventIndex]);
              messagesEventIndex++;
            }, max: messagesEvent.length),
          );

          await chatChannelUseCase.delete();

          // assert
          final captured = verify(
                  () => mockChatChannelRepository.deleteChannel(captureAny()))
              .captured;
          expect(captured.last, chatChannelRequest);
        },
        timeout: const Timeout(Duration(seconds: 2)),
      );

      test('handles failure correctly when unblocking a channel fails',
          () async {
        // arrange
        var failure = InternetConnectionFailure(); // fill in as needed
        when(() => mockChatChannelRepository.deleteChannel(any()))
            .thenAnswer((_) async => Left(failure));
        await load(
          chatChannelUseCase,
          user: chatUserEntity,
          repository: mockChatChannelRepository,
        );
        // act
        // Testando as mensagens do stream e para isto tenho que escutar o stream
        // antes de executar o método `block`.
        // Não quero que o stream emita evento, por isso o `count: 0, max: 0`.
        chatChannelUseCase.dataSource.listen(
          expectAsync1((event) {}, count: 0, max: 0),
        );

        await chatChannelUseCase.delete();

        // assert
        verify(() => mockChatChannelRepository.deleteChannel(any()));
      });
    });

    group('sentMessage method', () {
      test('sends a message', () async {
        // arrange
        List<ChatChannelUseCaseEvent> messagesEvent = [
          ChatChannelUseCaseEvent.updateMessage([
            ChatChannelMessage(
                content: ChatMessageEntity(
                  id: 123,
                  isMe: true,
                  message: 'Test message',
                  time: DateTime.now(),
                ),
                type: ChatChannelMessageType.text),
          ]),
        ];
        var messagesEventIndex = 0;

        when(() => mockChatChannelRepository.sentMessage(any())).thenAnswer(
          (_) async => right(
            ChatSentMessageResponseEntity(
              id: 123,
              currentMessageEtag: 'efgh',
              lastMessageEtag: 'abcd',
            ),
          ),
        ); // fill in as needed
        await load(
          chatChannelUseCase,
          user: chatUserEntity,
          repository: mockChatChannelRepository,
        );
        // act
        // Testando as mensagens do stream e para isto tenho que escutar o stream
        // antes de executar o método `block`.
        // Se ocorrer algum alteração no stream, o teste falhará
        chatChannelUseCase.dataSource.listen(
          expectAsync1((actualEvent) {
            final expectedEvent = messagesEvent[messagesEventIndex];
            expect(actualEvent, expectedEvent);

            messagesEventIndex++;
          }, max: messagesEvent.length),
        );

        await chatChannelUseCase.sentMessage('Test message');
        // assert
        verify(() => mockChatChannelRepository.sentMessage(any()));
      });
    });
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

Future<void> load(
  ChatChannelUseCase chatChannel, {
  required ChatUserEntity user,
  required IChatChannelRepository repository,
}) async {
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
  // assert
  final session = buildChatChannelSession(user);
  final StreamSubscription dataSource =
      chatChannel.dataSource.listen((event) {});
  when(() => repository.getMessages(any()))
      .thenAnswer((_) async => right(session));

  // act
  await Future.delayed(const Duration(seconds: 1), () {
    dataSource.cancel();
  });
  return Future.value();
}

class FakeChatChannelRequest extends Fake implements ChatChannelRequest {}
