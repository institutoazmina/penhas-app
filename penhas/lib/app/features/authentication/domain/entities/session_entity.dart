import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SessionEntity extends Equatable {
  final String sessionToken;
  final bool deletedScheduled;

  SessionEntity({
    @required this.sessionToken,
    @required this.deletedScheduled,
  });

  @override
  List<Object> get props => [sessionToken];

  @override
  bool get stringify => true;
}
