import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/extension/json_serializer.dart';
import '../../domain/entity/escape_manual.dart';
import 'escape_manual_mapper.dart'
    show readUserInputValue, userInputValueFromJson;
import 'escape_manual_task_type.dart';

export 'contact.dart';
export 'escape_manual_task_type.dart';

part 'escape_manual_local.g.dart';

@JsonSerializable()
class EscapeManualTaskLocalModel extends Equatable {
  const EscapeManualTaskLocalModel({
    required this.id,
    this.type = EscapeManualTaskType.normal,
    this.value,
    this.isDone = false,
    this.isRemoved = false,
    this.updatedAt,
  })  : assert(type != EscapeManualTaskType.unknown),
        assert(
          type != EscapeManualTaskType.contacts ||
              value is List<ContactEntity>?,
          'Item $id with invalid value: $value', // coverage:ignore-line
        );

  factory EscapeManualTaskLocalModel.fromJson(Map<String, dynamic> map) =>
      _$EscapeManualTaskLocalModelFromJson(map);

  @JsonKey(fromJson: FromJson.parseAsString)
  final String id;

  @JsonKey(
    defaultValue: EscapeManualTaskType.normal,
    unknownEnumValue: EscapeManualTaskType.unknown,
  )
  final EscapeManualTaskType type;

  @JsonKey(
    readValue: readUserInputValue,
    fromJson: userInputValueFromJson,
  )
  final dynamic value;

  @JsonKey()
  final bool isDone;

  @JsonKey()
  final bool isRemoved;

  @JsonKey()
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, type, value, isDone, isRemoved, updatedAt];

  Map<String, dynamic> toJson() => _$EscapeManualTaskLocalModelToJson(this);

  EscapeManualTaskLocalModel copyWith({
    bool? isDone,
    bool? isRemoved,
    DateTime? updatedAt,
  }) =>
      EscapeManualTaskLocalModel(
        id: id,
        type: type,
        value: value,
        isDone: isDone ?? this.isDone,
        isRemoved: isRemoved ?? this.isRemoved,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
