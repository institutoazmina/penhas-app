import 'package:equatable/equatable.dart';

import 'guardian_session_entity.dart';

abstract class GuardianTileEntity extends Equatable {}

class GuardianTileHeaderEntity extends GuardianTileEntity {
  GuardianTileHeaderEntity({required this.title});

  final String? title;

  @override
  List<Object?> get props => [title!];
}

class GuardianTileDescriptionEntity extends GuardianTileEntity {
  GuardianTileDescriptionEntity({required this.description});

  final String? description;

  @override
  List<Object?> get props => [description!];
}

class GuardianTileCardEntity extends GuardianTileEntity {
  GuardianTileCardEntity({
    required this.guardian,
    required this.deleteWarning,
    this.onEditPressed,
    this.onDeletePressed,
    this.onResendPressed,
  });

  final GuardianContactEntity guardian;
  final String? deleteWarning;
  final void Function(String name)? onEditPressed;
  final void Function()? onDeletePressed;
  final void Function()? onResendPressed;

  @override
  List<Object?> get props => [guardian, deleteWarning!];
}

class GuardianTileEmptyCardEntity extends GuardianTileEntity {
  GuardianTileEmptyCardEntity({required this.onPressed});

  final void Function() onPressed;

  @override
  List<Object?> get props => [];
}
