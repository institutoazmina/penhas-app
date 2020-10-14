import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_request.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_usecase_event.dart';

class ChatChannelUseCase with MapFailureMessage {
  final IChatChannelRepository _channelRepository;
  String _channelToken;
  String _newestPagination;
  String _oldestPagination;
  ChatChannelUseCaseEvent _currentEvent;
  ChatChannelSessionEntity _currentSession;

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

  // Future<void> message() {}
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

    if (_currentSession?.user != session.user) {
      _streamController.add(
        ChatChannelUseCaseEvent.updateUser(session.user),
      );
    }

    if (_currentSession?.metadata != session.metadata) {
      _streamController.add(
        ChatChannelUseCaseEvent.updateMetada(session.metadata),
      );
    }

    if (_currentSession == null) {
      _currentSession = session;
      _streamController.add(ChatChannelUseCaseEvent.loaded());
    }

    // _currentSession ??= session;
  }
}
