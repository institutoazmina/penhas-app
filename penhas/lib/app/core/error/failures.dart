import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ServerFailure extends Failure {}

class ServerSideSessionFailed extends Failure {}

class InternetConnectionFailure extends Failure {}

class UserAuthenticationFailure extends Failure {}

class UserAndPasswordInvalidFailure extends Failure {}

class EmailAddressInvalidFailure extends Failure {}

class PasswordInvalidFailure extends Failure {}

class NicknameInvalidFailure extends Failure {}

class CepInvalidFailure extends Failure {}

class CpfInvalidFailure extends Failure {}

class BirthdayInvalidFailure extends Failure {}

class FullnameInvalidFailure extends Failure {}

class HumanRaceInvalidFailure extends Failure {}

class GuardianAlertGpsFailure extends Failure {}

class RequiredParameter extends Failure {}

@immutable
class ServerSideFormFieldValidationFailure extends Failure {
  final String error;
  final String message;
  final String field;
  final String reason;

  ServerSideFormFieldValidationFailure({
    this.error,
    this.message,
    this.field,
    this.reason,
  });

  @override
  List<Object> get props => [error, message, field, reason];
}
