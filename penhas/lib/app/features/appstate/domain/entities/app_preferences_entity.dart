import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AppPreferencesEntity extends Equatable {
  const AppPreferencesEntity({
    required this.inactiveAppSince,
    required this.inactiveAppLogoutTimeInSeconds,
  });

  final int? inactiveAppSince;
  final int inactiveAppLogoutTimeInSeconds;

  @override
  List<Object?> get props => [inactiveAppSince, inactiveAppLogoutTimeInSeconds];

  @override
  bool get stringify => true;
}
