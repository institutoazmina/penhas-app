import 'dart:async';
import 'dart:collection';

import '../../../../core/error/failures.dart';
import '../../../../shared/logger/log.dart';
import '../../../authentication/presentation/shared/map_failure_message.dart';
import '../entities/chat_channel_message.dart';
import '../entities/chat_channel_open_entity.dart';
import '../entities/chat_channel_request.dart';
import '../entities/chat_channel_session_entity.dart';
import '../entities/chat_message_entity.dart';
import '../entities/chat_sent_message_response_entity.dart';
import '../repositories/chat_channel_repository.dart';
import '../states/chat_channel_usecase_event.dart';

class ChatChannelUseCase with MapFailureMessage {
  ChatChannelUseCase({
    required ChatChannelOpenEntity session,
    required IChatChannelRepository channelRepository,
  }) : _channelRepository = channelRepository {
    _streamController.add(_currentEvent);
    _initial(session);
  }

  final IChatChannelRepository _channelRepository;

  Timer? _syncTimer;
  String? _channelToken;
  String? _lastMessageEtag;
  ChatChannelUseCaseEvent _currentEvent =
      const ChatChannelUseCaseEvent.initial();
  ChatChannelSessionEntity? _currentSession;
  final _messageCache = Queue<ChatChannelMessage>();

  late final StreamController<ChatChannelUseCaseEvent> _streamController =
      StreamController.broadcast();
  Stream<ChatChannelUseCaseEvent> get dataSource => _streamController.stream;

  Future<void> block() async {
    await _blockChannel(isToBlock: true);
  }

  Future<void> unblock() async {
    await _blockChannel(isToBlock: false);
  }

  Future<void> delete() async {
    final response = await _channelRepository.deleteChannel(
      ChatChannelRequest(
        token: _channelToken,
      ),
    );

    response.fold(
      (failure) => _handleFailure(failure),
      (session) => _updateFromDeletedAction(),
    );
  }

  Future<void> sentMessage(String message) async {
    _syncTimer?.cancel();
    _syncTimer = null;

    final response = await _channelRepository.sentMessage(
      ChatChannelRequest(
        token: _channelToken,
        message: message,
      ),
    );

    response.fold(
      (failure) => _handleFailure(failure),
      (session) => _rebuildMessagesFromSentMessage(message, session),
    );

    _setupPollingSync();
  }

  void dispose() {
    if (_syncTimer != null) {
      _syncTimer!.cancel();
      _syncTimer = null;
    }
    _streamController.close();
  }

  // private methods
  Future<void> _initial(ChatChannelOpenEntity channel) async {
    _channelToken = channel.token;

    Future.delayed(
      const Duration(milliseconds: 200),
      () async {
        if (channel.session == null) {
          await _syncChannelSession(
            parameters: ChatChannelRequest(
              token: channel.token,
            ),
            insertWarningMessage: true,
          );
        } else {
          _handleSession(channel.session!, insertWarningMessage: true);
        }
      },
    );

    _setupPollingSync();
  }

  Future<void> _updateFromDeletedAction() async {
    _messageCache.clear();
    _streamController
        .add(ChatChannelUseCaseEvent.updateMessage(_messageCache.toList()));

    _currentSession = null;
    final option = ChatChannelRequest(token: _channelToken);
    _syncChannelSession(parameters: option, insertWarningMessage: true);
  }

  Future<void> _syncChannelSession({
    required ChatChannelRequest parameters,
    required bool insertWarningMessage,
  }) async {
    final result = await _channelRepository.getMessages(parameters);

    result.fold(
      (failure) => _handleFailure(failure),
      (session) =>
          _handleSession(session, insertWarningMessage: insertWarningMessage),
    );
  }

  Future<void> _handleFailure(Failure failure) async {
    final message = mapFailureMessage(failure);
    if (_currentEvent == const ChatChannelUseCaseEvent.initial()) {
      _currentEvent = ChatChannelUseCaseEvent.errorOnLoading(message);
      _streamController.add(_currentEvent);
    }

    logError(failure);
  }

  bool _hasWarningMessage(
    bool insertWarningMessage,
    ChatChannelSessionEntity session,
  ) {
    if (!insertWarningMessage) {
      return false;
    }

    return session.metadata?.headerWarning != null &&
        session.metadata!.headerWarning!.isNotEmpty;
  }

  void _handleSession(
    ChatChannelSessionEntity session, {
    required bool insertWarningMessage,
  }) {
    final List<ChatChannelMessage> messages = [];

    if (_currentSession?.user != session.user) {
      _streamController.add(ChatChannelUseCaseEvent.updateUser(session.user!));
    }

    if (_currentSession?.metadata != session.metadata) {
      _streamController
          .add(ChatChannelUseCaseEvent.updateMetadata(session.metadata!));

      if (_hasWarningMessage(insertWarningMessage, session)) {
        messages.add(
          ChatChannelMessage(
            type: ChatChannelMessageType.warning,
            content: ChatMessageEntity(
              id: -1,
              isMe: false,
              message: session.metadata!.headerWarning,
              time: DateTime.now(),
            ),
          ),
        );
      }
    }

    if (_currentSession == null) {
      _currentEvent = const ChatChannelUseCaseEvent.loaded();
      _streamController.add(_currentEvent);
    }

    if (_lastMessageEtag == session.metadata!.lastMessageEtag) {
      return;
    }

    _currentSession = session;
    _lastMessageEtag = session.metadata!.lastMessageEtag;

    messages.addAll(
      session.messages!.map(
        (e) => ChatChannelMessage(
          content: e,
          type: ChatChannelMessageType.text,
        ),
      ),
    );

    _messageCache.clear();
    _messageCache.addAll(messages);

    _streamController
        .add(ChatChannelUseCaseEvent.updateMessage(_messageCache.toList()));
  }

  void _rebuildMessagesFromSentMessage(
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

  Future<void> _blockChannel({required bool isToBlock}) async {
    final request = ChatChannelRequest(
      token: _channelToken,
      clientId: _currentSession!.user!.userId.toString(),
      block: isToBlock,
    );

    final response = await _channelRepository.blockChannel(request);

    response.fold(
      (failure) => _handleFailure(failure),
      (session) => _updateProfileAfterBlockAction(isToBlock: isToBlock),
    );
  }

  void _updateProfileAfterBlockAction({required bool isToBlock}) {
    final metadata = ChatChannelSessionMetadataEntity(
      canSendMessage: !isToBlock,
      didBlocked: isToBlock,
      headerMessage: _currentSession?.metadata?.headerMessage,
      headerWarning: _currentSession?.metadata?.headerWarning,
      isBlockable: _currentSession?.metadata?.isBlockable ?? false,
      lastMessageEtag: _currentSession?.metadata?.lastMessageEtag,
    );

    _streamController.add(
      ChatChannelUseCaseEvent.updateMetadata(metadata),
    );
  }

  void _setupPollingSync() {
    const pollingSyncInterval = Duration(seconds: 60);

    if (_syncTimer != null) {
      return;
    }

    _syncTimer = Timer.periodic(
      pollingSyncInterval,
      (timer) async {
        _syncChannel();
      },
    );
  }

  Future<void> _syncChannel() async {
    final option = ChatChannelRequest(token: _channelToken);
    await _syncChannelSession(parameters: option, insertWarningMessage: false);
  }
}
