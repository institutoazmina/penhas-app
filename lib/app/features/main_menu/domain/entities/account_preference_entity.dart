import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AccountPreferenceEntity extends Equatable {
  const AccountPreferenceEntity({
    required this.key,
    required this.label,
    required this.value,
  });

  final String key;
  final String? label;
  final bool value;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        key,
        label,
        value,
      ];
}

@immutable
class AccountPreferenceSessionEntity extends Equatable {
  const AccountPreferenceSessionEntity({required this.preferences});

  final List<AccountPreferenceEntity> preferences;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [preferences];
}
