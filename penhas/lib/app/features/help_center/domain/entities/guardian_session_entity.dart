import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class GuardianSessioEntity extends Equatable {
  final int remainingInvites;
  final List<GuardianEntity> guards;

  GuardianSessioEntity({
    @required this.remainingInvites,
    @required this.guards,
  });

  @override
  List<Object> get props => [remainingInvites, guards];

  @override
  bool get stringify => true;
}

@immutable
class GuardianEntity extends Equatable {
  final GuardianSessionMeta meta;
  final List<GuardianContactEntity> contacts;

  GuardianEntity({
    @required this.meta,
    @required this.contacts,
  });

  @override
  List<Object> get props => [meta, contacts];

  @override
  bool get stringify => true;
}

enum GuardianStatus { accepted, pending }

@immutable
class GuardianSessionMeta extends Equatable {
  final bool canResend;
  final String deleteWarning;
  final String description;
  final String header;
  final GuardianStatus status;

  GuardianSessionMeta({
    @required this.canResend,
    @required this.deleteWarning,
    @required this.description,
    @required this.header,
    @required this.status,
  });

  @override
  List<Object> get props => [
        canResend,
        deleteWarning,
        description,
        header,
        status,
      ];

  @override
  bool get stringify => true;
}

@immutable
class GuardianContactEntity extends Equatable {
  final int id;
  final String name;
  final String mobile;
  final String status;

  GuardianContactEntity({
    @required this.id,
    @required this.name,
    @required this.mobile,
    @required this.status,
  });

  factory GuardianContactEntity.createRequest({
    @required String name,
    @required String mobile,
  }) {
    return GuardianContactEntity(
      id: null,
      status: null,
      name: name,
      mobile: mobile,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        mobile,
        status,
      ];

  @override
  bool get stringify => true;
}
