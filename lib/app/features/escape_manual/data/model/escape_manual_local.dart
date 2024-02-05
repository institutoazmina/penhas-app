import 'package:json_annotation/json_annotation.dart';

import '../../../../core/extension/json_serializer.dart';
import 'escape_manual_mapper.dart'
    show readUserInputValue, userInputValueFromJson;
import 'escape_manual_task.dart';
import 'escape_manual_task_type.dart';

export 'contact.dart';
export 'escape_manual_task_type.dart';

part 'escape_manual_local.g.dart';

@JsonSerializable()
class EscapeManualTaskLocalModel extends EscapeManualTaskModel {
  const EscapeManualTaskLocalModel({
    required this.id,
    this.type = EscapeManualTaskType.normal,
    this.value,
    this.isDone = false,
    this.isRemoved = false,
    this.updatedAt,
  }) : super(type: type, value: value);

  factory EscapeManualTaskLocalModel.fromJson(Map<String, dynamic> map) =>
      _$EscapeManualTaskLocalModelFromJson(map);

  @override
  @JsonKey(fromJson: FromJson.parseAsString)
  final String id;

  @override
  @JsonKey(
    unknownEnumValue: EscapeManualTaskType.unknown,
  )
  final EscapeManualTaskType type;

  @override
  @JsonKey(
    readValue: readUserInputValue,
    fromJson: userInputValueFromJson,
  )
  final dynamic value;

  @override
  @JsonKey()
  final bool isDone;

  @override
  @JsonKey()
  final bool isRemoved;

  @override
  @JsonKey()
  final DateTime? updatedAt;

  @override
  Map<String, dynamic> toJson() => _$EscapeManualTaskLocalModelToJson(this);

  @override
  EscapeManualTaskLocalModel copyWith({
    dynamic value,
    bool? isDone,
    bool? isRemoved,
    DateTime? updatedAt,
  }) =>
      EscapeManualTaskLocalModel(
        id: id,
        type: type,
        value: value ?? this.value,
        isDone: isDone ?? this.isDone,
        isRemoved: isRemoved ?? this.isRemoved,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
