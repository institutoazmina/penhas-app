import 'package:meta/meta.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';

class SessionModel extends SessionEntity {
  SessionModel({
    @required bool fakePassword,
    @required String sessionToken,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    var fakePassword = json['senha_falsa'] > 0;
    return SessionModel(
        fakePassword: fakePassword, sessionToken: json['session']);
  }
}
