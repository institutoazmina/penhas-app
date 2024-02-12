import 'package:equatable/equatable.dart';

import '../../domain/entity/contact.dart';
import 'escape_manual_task_type.dart';

abstract class EscapeManualTaskModel extends Equatable {
  /// Creates a [EscapeManualTaskModel] with the given [type] and [value].
  /// The constructor is just to assert the type of [value] based on the [type].
  /// coverage:ignore-start
  const EscapeManualTaskModel({
    required EscapeManualTaskType type,
    dynamic value,
  })  : assert(
          type != EscapeManualTaskType.contacts ||
              value is List<ContactEntity>?,
          'The `value` must be a `List<ContactEntity>` '
          'when the type is `contacts`',
        ),
        assert(type != EscapeManualTaskType.unknown);
  // coverage:ignore-end

  String get id;

  EscapeManualTaskType get type;

  dynamic get value;

  bool get isDone;

  bool get isRemoved;

  DateTime? get updatedAt;

  @override
  List<Object?> get props => [id, type, value, isRemoved];

  Map<String, Object?> toJson();

  EscapeManualTaskModel copyWith({
    dynamic value,
    bool? isDone,
    bool? isRemoved,
    DateTime? updatedAt,
  });
}
