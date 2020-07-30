import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'guardian_session_entity.dart';

abstract class GuardianTileEntity extends Equatable {}

class GuardianTileHeaderEntity extends GuardianTileEntity {
  final String title;

  GuardianTileHeaderEntity({@required this.title});

  @override
  List<Object> get props => [title];
}

class GuardianTileDescriptionEntity extends GuardianTileEntity {
  final String description;

  GuardianTileDescriptionEntity({@required this.description});

  @override
  List<Object> get props => [description];
}

class GuardianTileCardEntity extends GuardianTileEntity {
  final GuardianContactEntity guardian;
  final String deleteWarning;
  final void Function(String name) onEditPressed;
  final void Function() onDeletePressed;
  final void Function() onResendPressed;

  GuardianTileCardEntity({
    @required this.guardian,
    @required this.deleteWarning,
    this.onEditPressed,
    this.onDeletePressed,
    this.onResendPressed,
  });

  @override
  List<Object> get props => [guardian, deleteWarning];
}

class GuardianTileEmptyCardEntity extends GuardianTileEntity {
  final void Function() onPressed;

  GuardianTileEmptyCardEntity({@required this.onPressed});
  @override
  List<Object> get props => [];
}
