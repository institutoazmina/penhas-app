import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class AppPreferencesEntity extends Equatable {
  final int inactiveAppSince;
  final int inactiveAppLogoutTime;

  AppPreferencesEntity({
    @required this.inactiveAppSince,
    @required this.inactiveAppLogoutTime,
  });

  @override
  List<Object> get props => [inactiveAppSince, inactiveAppLogoutTime];

  @override
  bool get stringify => true;
}
