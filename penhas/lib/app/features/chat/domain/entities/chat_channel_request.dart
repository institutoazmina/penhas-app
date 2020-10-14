import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ChatChannelRequest extends Equatable {
  final int rows;
  final String token;
  final String pagination;
  final String message;

  ChatChannelRequest({
    @required this.token,
    this.rows = 100,
    this.message,
    this.pagination,
  });
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [token, pagination, rows];
}
