import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class AppPreferencesEntity extends Equatable {
  final int inactiveAppSince;
  final int inactiveAppLogoutTimeInSeconds;

  AppPreferencesEntity({
    @required this.inactiveAppSince,
    @required this.inactiveAppLogoutTimeInSeconds,
  });

  @override
  List<Object> get props => [inactiveAppSince, inactiveAppLogoutTimeInSeconds];

  @override
  bool get stringify => true;
}
