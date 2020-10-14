import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ChatSentMessageResponseEntity extends Equatable {
  final int id;
  final String lastMessageEtag;
  final String currentMessageEtag;

  ChatSentMessageResponseEntity({
    @required this.id,
    @required this.lastMessageEtag,
    @required this.currentMessageEtag,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        lastMessageEtag,
        currentMessageEtag,
      ];

  factory ChatSentMessageResponseEntity.fromJson(Map<String, Object> jsonData) {
    return ChatSentMessageResponseEntity(
      id: jsonData['id'],
      currentMessageEtag: jsonData['last_msg_etag'],
      lastMessageEtag: jsonData['prev_last_msg_etag'],
    );
  }
}
