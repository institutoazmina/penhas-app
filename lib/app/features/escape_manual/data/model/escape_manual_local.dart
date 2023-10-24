import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/extension/json_serializer.dart';
import '../../domain/entity/escape_manual.dart';

part 'escape_manual_local.g.dart';

@JsonSerializable()
class EscapeManualTaskLocalModel extends Equatable {
  const EscapeManualTaskLocalModel({
    required this.id,
    this.isDone = false,
    this.isRemoved = false,
    this.updatedAt,
  });

  factory EscapeManualTaskLocalModel.fromEntity(
    EscapeManualTaskEntity entity,
  ) =>
      EscapeManualTaskLocalModel(
        id: entity.id,
        isDone: entity.isDone,
      );

  factory EscapeManualTaskLocalModel.fromJson(Map<String, dynamic> map) =>
      _$EscapeManualTaskLocalModelFromJson(map);

  static Iterable<EscapeManualTaskLocalModel> fromJsonList(
    List<dynamic> map,
  ) =>
      map.map<EscapeManualTaskLocalModel>(
        (task) => EscapeManualTaskLocalModel.fromJson(task),
      );

  @JsonKey(fromJson: FromJson.parseAsString)
  final String id;

  @JsonKey()
  final bool isDone;

  @JsonKey()
  final bool isRemoved;

  @JsonKey()
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [id, isDone, isRemoved, updatedAt];

  Map<String, dynamic> toJson() => _$EscapeManualTaskLocalModelToJson(this);

  EscapeManualTaskLocalModel copyWith({
    bool? isDone,
    bool? isRemoved,
    DateTime? updatedAt,
  }) =>
      EscapeManualTaskLocalModel(
        id: id,
        isDone: isDone ?? this.isDone,
        isRemoved: isRemoved ?? this.isRemoved,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
