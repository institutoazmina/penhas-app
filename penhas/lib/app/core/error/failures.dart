import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  @override
  List<dynamic> get props => [];

  @override
  bool get stringify => true;
}

class ServerFailure extends Failure {}

class ServerSideSessionFailed extends Failure {}

class InternetConnectionFailure extends Failure {}

class UserAndPasswordInvalidFailure extends Failure {}

class EmailAddressInvalidFailure extends Failure {}

class NicknameInvalidFailure extends Failure {}

class CepInvalidFailure extends Failure {}

class CpfInvalidFailure extends Failure {}

class BirthdayInvalidFailure extends Failure {}

class FullnameInvalidFailure extends Failure {}

class HumanRaceInvalidFailure extends Failure {}

class GuardianAlertGpsFailure extends Failure {}

class RequiredParameter extends Failure {}

class AudioDownloadFailure extends Failure {}

class FileSystemFailure extends Failure {}

class GpsFailure extends Failure {
  final String? message;

  GpsFailure(this.message);

  final String? message;

  @override
  List<Object> get props => [message!];
}

class AddressFailure extends Failure {
  final String? message;

  AddressFailure(this.message);

  final String? message;

  @override
  List<Object> get props => [message!];
}

@immutable
class ServerSideFormFieldValidationFailure extends Failure {
  final String? error;
  final String? message;
  final String? field;
  final String? reason;

  ServerSideFormFieldValidationFailure({
    this.error,
    this.message,
    this.field,
    this.reason,
  });

  final String? error;
  final String? message;
  final String? field;
  final String? reason;

  @override
  List<Object> get props => [error!, message!, field!, reason!];
}
