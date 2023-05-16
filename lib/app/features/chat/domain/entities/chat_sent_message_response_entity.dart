import 'package:equatable/equatable.dart';

class ChatSentMessageResponseEntity extends Equatable {
  const ChatSentMessageResponseEntity({
    required this.id,
    required this.lastMessageEtag,
    required this.currentMessageEtag,
  });

  factory ChatSentMessageResponseEntity.fromJson(
    Map<String, dynamic> jsonData,
  ) {
    return ChatSentMessageResponseEntity(
      id: jsonData['id'] as int?,
      currentMessageEtag: jsonData['last_msg_etag'] as String?,
      lastMessageEtag: jsonData['prev_last_msg_etag'] as String?,
    );
  }

  final int? id;
  final String? lastMessageEtag;
  final String? currentMessageEtag;

  @override
  List<Object?> get props => [
        id!,
        lastMessageEtag!,
        currentMessageEtag!,
      ];
}
