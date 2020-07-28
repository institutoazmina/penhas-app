import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GuardianTileEntity extends Equatable {}

class GuardianTileHeaderEntity extends GuardianTileEntity {
  final String title;

  GuardianTileHeaderEntity({@required this.title});

  @override
  List<Object> get props => [title];
}
