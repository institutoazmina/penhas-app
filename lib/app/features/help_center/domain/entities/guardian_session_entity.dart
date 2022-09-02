import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class GuardianSessioEntity extends Equatable {
  const GuardianSessioEntity({
    required this.remainingInvites,
    required this.maximumInvites,
    required this.guards,
  });

  final int remainingInvites;
  final int maximumInvites;
  final List<GuardianEntity> guards;

  @override
  List<Object?> get props => [remainingInvites, maximumInvites, guards];

  @override
  bool get stringify => true;
}

@immutable
class GuardianEntity extends Equatable {
  const GuardianEntity({
    required this.meta,
    required this.contacts,
  });

  final GuardianSessionMeta meta;
  final List<GuardianContactEntity> contacts;

  @override
  List<Object?> get props => [meta, contacts];

  @override
  bool get stringify => true;
}

enum GuardianStatus { accepted, pending }

@immutable
class GuardianSessionMeta extends Equatable {
  const GuardianSessionMeta({
    required this.canEdit,
    required this.canDelete,
    required this.canResend,
    required this.deleteWarning,
    required this.description,
    required this.header,
    required this.status,
  });

  final bool canEdit;
  final bool canDelete;
  final bool canResend;
  final String? deleteWarning;
  final String? description;
  final String? header;
  final GuardianStatus status;

  @override
  List<Object?> get props => [
        canEdit,
        canDelete,
        canResend,
        deleteWarning!,
        description!,
        header!,
        status,
      ];

  @override
  bool get stringify => true;
}

@immutable
class GuardianContactEntity extends Equatable {
  const GuardianContactEntity({
    required this.id,
    required this.name,
    required this.mobile,
    required this.status,
  });

  factory GuardianContactEntity.createRequest({
    required String? name,
    required String? mobile,
  }) {
    return GuardianContactEntity(
      id: null,
      status: null,
      name: name,
      mobile: mobile,
    );
  }

  final int? id;
  final String? name;
  final String? mobile;
  final String? status;

  GuardianContactEntity copyWith({
    int? id,
    String? name,
    String? mobile,
    String? status,
  }) =>
      GuardianContactEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        mobile,
        status,
      ];

  @override
  bool get stringify => true;
}
