import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SessionEntity extends Equatable {
  final String sessionToken;

  SessionEntity({
    @required this.sessionToken,
  });

  @override
  List<Object> get props => [sessionToken];

  @override
  bool get stringify => true;
}
