import 'package:equatable/equatable.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_message_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';

class ChatChannelSessionEntity extends Equatable {
  const ChatChannelSessionEntity({
    required this.hasMore,
    required this.newer,
    required this.older,
    required this.messages,
    required this.metadata,
    required this.user,
  });

  final bool? hasMore;
  final String? newer;
  final String? older;
  final List<ChatMessageEntity>? messages;
  final ChatChannelSessionMetadataEntity? metadata;
  final ChatUserEntity? user;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        hasMore,
        newer,
        older,
        messages,
        metadata,
        user,
      ];
}

class ChatChannelSessionMetadataEntity extends Equatable {
  const ChatChannelSessionMetadataEntity({
    required this.canSendMessage,
    required this.didBlocked,
    required this.headerMessage,
    required this.headerWarning,
    required this.isBlockable,
    required this.lastMessageEtag,
  });

  final bool canSendMessage;
  final bool didBlocked;
  final String? headerMessage;
  final String? headerWarning;
  final bool isBlockable;
  final String? lastMessageEtag;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        canSendMessage,
        didBlocked,
        headerMessage,
        headerWarning,
        isBlockable,
        lastMessageEtag,
      ];

  static final ChatChannelSessionMetadataEntity empty =
      const ChatChannelSessionMetadataEntity(
    didBlocked: false,
    isBlockable: false,
    canSendMessage: false,
    headerMessage: null,
    headerWarning: null,
    lastMessageEtag: null,
  );
}
