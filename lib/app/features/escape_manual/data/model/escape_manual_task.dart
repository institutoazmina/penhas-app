import 'package:equatable/equatable.dart';

import 'escape_manual_task_type.dart';

abstract class EscapeManualTaskModel extends Equatable {
  const EscapeManualTaskModel();

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
