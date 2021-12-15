import 'package:equatable/equatable.dart';

class ChatChannelRequest extends Equatable {
  final int rows;
  final String? token;
  final String? pagination;
  final String? message;
  final String? clientId;
  final bool? block;

  const ChatChannelRequest({
    required this.token,
    this.rows = 100,
    this.message,
    this.pagination,
    this.clientId,
    this.block,
  });

  final int rows;
  final String? token;
  final String? pagination;
  final String? message;
  final String? clientId;
  final bool? block;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        token,
        pagination,
        rows,
        clientId,
        block,
      ];
}
