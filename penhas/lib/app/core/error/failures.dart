import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties;

  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class UserAndPasswordInvalidFailure extends Failure {}

class EmailAddressInvalidFailure extends Failure {}

class PasswordInvalidFailure extends Failure {}

class NicknameInvalidFailure extends Failure {}

class CepInvalidFailure extends Failure {}

class CpfInvalidFailure extends Failure {}

class BirthdayInvalidFailure extends Failure {}

class FullnameInvalidFailure extends Failure {}

class HumanRaceInvalidFailure extends Failure {}
