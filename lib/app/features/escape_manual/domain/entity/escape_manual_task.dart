import 'package:equatable/equatable.dart';

import 'button.dart';
import 'contact.dart';

export 'button.dart';
export 'contact.dart';

abstract class EscapeManualTaskEntity extends Equatable {
  const EscapeManualTaskEntity({
    required this.id,
    required this.description,
  });

  final String id;
  final String description;

  @override
  List<Object?> get props => [
        id,
        description,
      ];
}

abstract class EscapeManualTodoTaskEntity extends EscapeManualTaskEntity {
  const EscapeManualTodoTaskEntity({
    required super.id,
    required super.description,
    required this.isDone,
  });

  final bool isDone;

  @override
  List<Object?> get props => [
        ...super.props,
        isDone,
      ];

  EscapeManualTodoTaskEntity copyWith({
    bool? isDone,
  });
}

abstract class EscapeManualEditableTaskEntity<T extends Object>
    extends EscapeManualTodoTaskEntity {
  const EscapeManualEditableTaskEntity({
    required super.id,
    required super.description,
    required this.value,
    required super.isDone,
  });

  final T? value;

  @override
  List<Object?> get props => [
        ...super.props,
        value,
      ];

  @override
  EscapeManualTodoTaskEntity copyWith({
    bool? isDone,
    T? value,
  });
}

class EscapeManualDefaultTaskEntity extends EscapeManualTodoTaskEntity {
  const EscapeManualDefaultTaskEntity({
    required super.id,
    required super.description,
    super.isDone = false,
  });

  @override
  EscapeManualTodoTaskEntity copyWith({
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
    required super.id,
    required super.description,
    super.value,
    super.isDone = false,
  });

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

class EscapeManualButtonTaskEntity extends EscapeManualTaskEntity {
  const EscapeManualButtonTaskEntity({
    required super.id,
    String? description,
    required this.button,
  }) : super(
          description: description ?? '',
        );

  final ButtonEntity button;

  @override
  List<Object?> get props => [
        ...super.props,
        button,
      ];
}
