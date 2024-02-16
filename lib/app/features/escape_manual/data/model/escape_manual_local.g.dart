// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escape_manual_local.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EscapeManualTaskLocalModel _$EscapeManualTaskLocalModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualTaskLocalModel(
      id: FromJson.parseAsString(json['id']),
      type: $enumDecodeNullable(_$EscapeManualTaskTypeEnumMap, json['type'],
              unknownValue: EscapeManualTaskType.unknown) ??
          EscapeManualTaskType.normal,
      value: userInputValueFromJson(
          readUserInputValue(json, 'value') as Map<String, dynamic>),
      isDone: json['isDone'] as bool? ?? false,
      isRemoved: json['isRemoved'] as bool? ?? false,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$EscapeManualTaskLocalModelToJson(
    EscapeManualTaskLocalModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'type': _$EscapeManualTaskTypeEnumMap[instance.type]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  val['isDone'] = instance.isDone;
  val['isRemoved'] = instance.isRemoved;
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  return val;
}

const _$EscapeManualTaskTypeEnumMap = {
  EscapeManualTaskType.unknown: 'unknown',
  EscapeManualTaskType.normal: 'checkbox',
  EscapeManualTaskType.contacts: 'checkbox_contato',
  EscapeManualTaskType.button: 'button',
};
