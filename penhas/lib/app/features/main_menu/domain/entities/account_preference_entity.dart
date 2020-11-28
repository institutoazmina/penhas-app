import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class AccountPreferenceEntity extends Equatable {
  final String key;
  final String label;
  final bool value;

  AccountPreferenceEntity({
    @required this.key,
    @required this.label,
    @required this.value,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        this.key,
        this.label,
        this.value,
      ];
}

@immutable
class AccountPreferenceSessionEntity extends Equatable {
  final List<AccountPreferenceEntity> preferences;

  AccountPreferenceSessionEntity({@required this.preferences});

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [preferences];
}
