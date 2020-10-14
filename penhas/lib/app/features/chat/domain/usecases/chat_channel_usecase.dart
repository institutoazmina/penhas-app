import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_request.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/repositories/chat_channel_repository.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_usecase_event.dart';

class ChatChannelUseCase {
  final IChatChannelRepository _channelRepository;
  String _channelToken;
  String _newestPagination;
  String _oldestPagination;

  final StreamController<ChatChannelUseCaseEvent> _streamController =
      StreamController.broadcast();
  Stream<ChatChannelUseCaseEvent> get dataSource => _streamController.stream;

  ChatChannelUseCase({
    @required ChatChannelOpenEntity session,
    @required IChatChannelRepository channelRepository,
  }) : this._channelRepository = channelRepository {
    _streamController.add(ChatChannelUseCaseEvent.initial());
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

  void handleFailure(Failure failure) {
    print(failure);
  }

  void handleSession(ChatChannelSessionEntity session) {
    print(session);
  }
}
