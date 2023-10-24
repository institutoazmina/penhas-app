// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escape_manual_local.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EscapeManualTaskLocalModel _$EscapeManualTaskLocalModelFromJson(
        Map<String, dynamic> json) =>
    EscapeManualTaskLocalModel(
      id: FromJson.parseAsString(json['id']),
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
    'isDone': instance.isDone,
    'isRemoved': instance.isRemoved,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  return val;
}
