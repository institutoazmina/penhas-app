import 'package:equatable/equatable.dart';

import 'button.dart';
import 'contact.dart';

export 'contact.dart';
export 'button.dart';

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
    required String id,
    required String description,
    required this.isDone,
  }) : super(
          id: id,
          description: description,
        );

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
  EscapeManualTodoTaskEntity copyWith({
    bool? isDone,
    T? value,
  });
}

class EscapeManualDefaultTaskEntity extends EscapeManualTodoTaskEntity {
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

class EscapeManualButtonTaskEntity extends EscapeManualTaskEntity {
  const EscapeManualButtonTaskEntity({
    required String id,
    String? description,
    required this.button,
  }) : super(
          id: id,
          description: description ?? '',
        );

  final ButtonEntity button;

  @override
  List<Object?> get props => [
        ...super.props,
        button,
      ];
}
