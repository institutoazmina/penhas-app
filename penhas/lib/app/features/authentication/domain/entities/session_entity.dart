import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String? sessionToken;
  final bool deletedScheduled;

  const SessionEntity({
    required this.sessionToken,
    this.deletedScheduled = false,
  });

  final String? sessionToken;
  final bool deletedScheduled;

  @override
  List<Object?> get props => [sessionToken, deletedScheduled];

  @override
  bool get stringify => true;
}
