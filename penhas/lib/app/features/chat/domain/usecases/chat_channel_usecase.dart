import 'dart:async';
import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_request.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_sent_message_response_entity.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_usecase_event.dart';

class ChatChannelUseCase with MapFailureMessage {
  final IChatChannelRepository _channelRepository;
  String _channelToken;
  String _newestPagination;
  String _oldestPagination;
  String _lastMessageEtag;
  ChatChannelUseCaseEvent _currentEvent;
  ChatChannelSessionEntity _currentSession;
  final _messageCache = Queue<ChatChannelMessage>();

  final StreamController<ChatChannelUseCaseEvent> _streamController =
      StreamController.broadcast();
  Stream<ChatChannelUseCaseEvent> get dataSource => _streamController.stream;

  ChatChannelUseCase({
    @required ChatChannelOpenEntity session,
    @required IChatChannelRepository channelRepository,
  }) : this._channelRepository = channelRepository {
    _currentEvent = ChatChannelUseCaseEvent.initial();
    _streamController.add(_currentEvent);
    initial(session);
  }

  void dispose() {
    _streamController.close();
  }
  // Future<void> block() {}

  // Future<void> unblock() {}

  // Future<void> delete() {}

  Future<void> sentMessage(String message) async {
    final response = await _channelRepository.sentMessage(
      ChatChannelRequest(
        token: _channelToken,
        message: message,
      ),
    );

    response.fold(
      (failure) => handleFailure(failure),
      (session) => rebuildMessagesFromSentMessage(message, session),
    );
  }
}

extension ChatChannelUseCasePrivateMethods on ChatChannelUseCase {
  Future<void> initial(ChatChannelOpenEntity channel) async {
    _channelToken = channel.token;

    if (channel.session == null) {
      getMessage(ChatChannelRequest(token: channel.token, pagination: null));
    }
  }

  Future<void> getMessage(ChatChannelRequest parameters) async {
    final session = await _channelRepository.getMessages(parameters);
    parseChannelSession(session);
  }

  void parseChannelSession(Either<Failure, ChatChannelSessionEntity> session) {
    session.fold(
      (failure) => handleFailure(failure),
      (session) => handleSession(session),
    );
  }

  void handleFailure(Failure failure) async {
    final message = mapFailureMessage(failure);
    if (_currentEvent == ChatChannelUseCaseEvent.initial()) {
      _currentEvent = ChatChannelUseCaseEvent.errorOnLoading(message);
      _streamController.add(_currentEvent);
    }

    print(failure);
  }

  void handleSession(ChatChannelSessionEntity session) {
    _newestPagination = session.newer;
    _oldestPagination = session.older;
    ChatChannelMessage warningMessage;
    List<ChatChannelMessage> messages = List<ChatChannelMessage>();

    if (_currentSession?.user != session.user) {
      _streamController.add(
        ChatChannelUseCaseEvent.updateUser(session.user),
      );
    }

    if (_currentSession?.metadata != session.metadata) {
      _streamController.add(
        ChatChannelUseCaseEvent.updateMetada(session.metadata),
      );
      if (session.metadata.headerWarning != null ||
          session.metadata.headerWarning.isNotEmpty) {
        warningMessage = ChatChannelMessage(
          type: ChatChannelMessageType.warning,
          content: ChatMessageEntity(
            id: -1,
            isMe: false,
            message: session.metadata.headerWarning,
            time: DateTime.now(),
          ),
        );
      }
    }

    if (_currentSession == null) {
      _currentEvent = ChatChannelUseCaseEvent.loaded();
      _streamController.add(_currentEvent);
    }

    _currentSession = session;
    _lastMessageEtag = session.metadata.lastMessageEtag;

    messages.addAll(
      session.messages.map(
        (e) => ChatChannelMessage(
          content: e,
          type: ChatChannelMessageType.text,
        ),
      ),
    );

    if (warningMessage != null) {
      messages.add(warningMessage);
    }

    if (messages.isNotEmpty) {
      _streamController.add(ChatChannelUseCaseEvent.updateMessage(messages));
    }

    _messageCache.addAll(messages);
  }

  void rebuildMessagesFromSentMessage(
    String message,
    ChatSentMessageResponseEntity response,
  ) {
    _messageCache.removeWhere(
      (e) => e.type == ChatChannelMessageType.warning,
    );

    _messageCache.addFirst(
      ChatChannelMessage(
        type: ChatChannelMessageType.text,
        content: ChatMessageEntity(
          id: response.id,
          time: DateTime.now(),
          isMe: true,
          message: message,
        ),
      ),
    );

    _streamController.add(
      ChatChannelUseCaseEvent.updateMessage(_messageCache.toList()),
    );

    if (_lastMessageEtag == response.lastMessageEtag) {
      _lastMessageEtag = response.currentMessageEtag;
    } else {
      // rebuild a lista
    }
  }
}
