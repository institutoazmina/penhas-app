import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String? sessionToken;
  final bool deletedScheduled;

  SessionEntity({
    required this.sessionToken,
    required this.deletedScheduled,
  });

  final String? sessionToken;
  final bool deletedScheduled;

  @override
  List<Object> get props => [sessionToken!];

  @override
  bool get stringify => true;
}
