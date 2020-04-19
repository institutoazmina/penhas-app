import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SessionEntity extends Equatable {
  final bool fakePassword;
  final String sessionToken;

  SessionEntity({
    @required this.fakePassword,
    @required this.sessionToken,
  });

  @override
  List<Object> get props => [fakePassword, sessionToken];
}
