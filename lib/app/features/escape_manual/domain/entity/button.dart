import 'package:equatable/equatable.dart';

class ButtonEntity extends Equatable {
  const ButtonEntity({
    required this.label,
    required this.route,
    this.arguments,
  });

  final String label;
  final String route;
  final dynamic arguments;

  @override
  List<Object?> get props => [label, route, arguments];
}
