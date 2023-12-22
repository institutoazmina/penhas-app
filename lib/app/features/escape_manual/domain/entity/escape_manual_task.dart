import 'package:equatable/equatable.dart';

import 'contact.dart';

export 'contact.dart';

abstract class EscapeManualTaskEntity extends Equatable {
  const EscapeManualTaskEntity({
    required this.id,
    required this.description,
    required this.isDone,
  });

  final String id;
  final String description;
  final bool isDone;

  @override
  List<Object?> get props => [
        id,
        description,
        isDone,
      ];

  EscapeManualTaskEntity copyWith({
    bool? isDone,
  });
}

abstract class EscapeManualEditableTaskEntity<T extends Object>
    extends EscapeManualTaskEntity {
  const EscapeManualEditableTaskEntity({
    required String id,
    required String description,
    required this.value,
    required bool isDone,
  }) : super(
          id: id,
          description: description,
          isDone: isDone,
        );

  final T? value;

  @override
  List<Object?> get props => [
        ...super.props,
        value,
      ];

  @override
  EscapeManualTaskEntity copyWith({
    bool? isDone,
    T? value,
  });
}

class EscapeManualDefaultTaskEntity extends EscapeManualTaskEntity {
  const EscapeManualDefaultTaskEntity({
    required String id,
    required String description,
    bool isDone = false,
  }) : super(
          id: id,
          description: description,
          isDone: isDone,
        );

  @override
  EscapeManualTaskEntity copyWith({
    bool? isDone,
  }) =>
      EscapeManualDefaultTaskEntity(
        id: id,
        description: description,
        isDone: isDone ?? this.isDone,
      );
}

class EscapeManualContactsTaskEntity
    extends EscapeManualEditableTaskEntity<List<ContactEntity>> {
  const EscapeManualContactsTaskEntity({
    required String id,
    required String description,
    List<ContactEntity>? value,
    bool isDone = false,
  }) : super(
          id: id,
          description: description,
          value: value,
          isDone: isDone,
        );

  @override
  EscapeManualContactsTaskEntity copyWith({
    bool? isDone,
    List<ContactEntity>? value,
  }) =>
      EscapeManualContactsTaskEntity(
        id: id,
        description: description,
        value: value ?? this.value,
        isDone: isDone ?? this.isDone,
      );
}
