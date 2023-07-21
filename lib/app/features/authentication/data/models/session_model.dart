import '../../domain/entities/session_entity.dart';

class SessionModel extends SessionEntity {
  const SessionModel({
    required String? sessionToken,
    bool deletedScheduled = false,
  }) : super(
          sessionToken: sessionToken,
          deletedScheduled: deletedScheduled,
        );

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        sessionToken: json['session'],
        deletedScheduled: json['deleted_scheduled'] == 1,
      );
}
