import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ChatChannelRequest extends Equatable {
  final int rows;
  final String token;
  final String pagination;
  final String message;
  final String clientId;
  final bool block;

  ChatChannelRequest({
    @required this.token,
    this.rows = 100,
    this.message,
    this.pagination,
    this.clientId,
    this.block,
  });
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        token,
        pagination,
        rows,
        clientId,
        block,
      ];
}
