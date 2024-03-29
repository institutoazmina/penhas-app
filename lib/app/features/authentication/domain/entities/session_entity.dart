import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  const SessionEntity({
    required this.sessionToken,
    this.deletedScheduled = false,
  });

  final String? sessionToken;
  final bool deletedScheduled;

  @override
  List<Object?> get props => [sessionToken, deletedScheduled];
}
