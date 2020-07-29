import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
  final String name;
  final String mobile;
  final String status;
  final void Function() onEditPressed;
  final void Function() onDeletePressed;
  final void Function() onResendPressed;

// typedef VoidCallback = void Function();

  GuardianTileCardEntity({
    @required this.name,
    @required this.mobile,
    @required this.status,
    this.onEditPressed,
    this.onDeletePressed,
    this.onResendPressed,
  });

  @override
  List<Object> get props => [name, mobile, status];
}
