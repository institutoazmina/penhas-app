import 'package:equatable/equatable.dart';

import '../../domain/entity/contact.dart';
import 'escape_manual_task_type.dart';

abstract class EscapeManualTaskModel extends Equatable {
  /// Creates a [EscapeManualTaskModel] with the given [type] and [value].
  /// The constructor is just to assert the type of [value] based on the [type].
  const EscapeManualTaskModel({
    required EscapeManualTaskType type,
    dynamic value,
  })  : assert(
          type == EscapeManualTaskType.contacts
              ? value is List<ContactEntity>?
              : true,
          'Invalid value: $value for type $type', // coverage:ignore-line
        ),
        assert(type != EscapeManualTaskType.unknown);

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
