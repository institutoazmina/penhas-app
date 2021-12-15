import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AccountPreferenceEntity extends Equatable {
  final String? key;
  final String? label;
  final bool value;

  const AccountPreferenceEntity({
    required this.key,
    required this.label,
    required this.value,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        key!,
        label!,
        value,
      ];
}

@immutable
class AccountPreferenceSessionEntity extends Equatable {
  const AccountPreferenceSessionEntity({required this.preferences});

  const AccountPreferenceSessionEntity({required this.preferences});

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [preferences];
}
