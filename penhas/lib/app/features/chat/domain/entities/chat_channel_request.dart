import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ChatChannelRequest extends Equatable {
  final String token;
  final String pagination;
  final int rows;

  ChatChannelRequest({
    @required this.token,
    @required this.pagination,
    this.rows = 100,
  });
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [token, pagination, rows];
}
