import 'package:collection/collection.dart';

import '../../../../core/extension/iterable.dart';
import '../../../../shared/logger/log.dart';
import '../../domain/entity/escape_manual.dart';
import 'escape_manual_local.dart';
import 'escape_manual_remote.dart';

extension EscapeManualRemoteMapper on EscapeManualRemoteModel {
  /// Maps a [EscapeManualRemoteModel] to a [EscapeManualEntity].
  EscapeManualEntity get asEntity => EscapeManualEntity(
        assistant: assistant.asEntity,
        sections: tasks.asEntity,
      );
}

extension EscapeManualAssistantRemoteMapper
    on EscapeManualAssistantRemoteModel {
  /// Maps a [EscapeManualAssistantRemoteModel] to a [EscapeManualAssistantEntity].
  EscapeManualAssistantEntity get asEntity => EscapeManualAssistantEntity(
        explanation: subtitle ?? '',
        action: EscapeManualAssistantActionEntity(
          text: title,
          quizSession: quizSession,
        ),
      );
}

extension EscapeManualTasksSectionMapper
    on Iterable<EscapeManualTaskRemoteModel> {
  /// Maps a list of [EscapeManualTaskRemoteModel] to a list of
  /// [EscapeManualTasksSectionEntity] grouping them by [group].
  ///
  /// The [group] is the same as the [title] of the section.
  List<EscapeManualTasksSectionEntity> get asEntity =>
      groupListsBy((el) => el.group)
          .entries
          .map(
            (el) => EscapeManualTasksSectionEntity(
              title: el.key,
              tasks: el.value
                  .mapNotNull<EscapeManualTaskEntity>((el) => el.asEntity)
                  .toList(),
            ),
          )
          .toList();
}

extension EscapeManualTaskRemoteMapper on EscapeManualTaskRemoteModel {
  /// Maps a [EscapeManualTaskRemoteModel] to a [EscapeManualTaskEntity].
  EscapeManualTaskEntity? get asEntity {
    switch (type) {
      case EscapeManualTaskType.normal:
        return EscapeManualDefaultTaskEntity(
          id: id,
          description: description,
          isDone: isDone,
        );

      case EscapeManualTaskType.contacts:
        return EscapeManualContactsTaskEntity(
          id: id,
          description: description,
          isDone: isDone,
          value: value,
        );

      // coverage:ignore-start
      case EscapeManualTaskType.unknown:
        return null;
      // coverage:ignore-end
    }
  }
}

extension EscapeManualTaskEntityMapper on EscapeManualTaskEntity {
  EscapeManualTaskType get type {
    if (this is EscapeManualContactsTaskEntity) {
      return EscapeManualTaskType.contacts;
    }
    assert(this is EscapeManualDefaultTaskEntity);
    return EscapeManualTaskType.normal;
  }

  EscapeManualTaskLocalModel get asLocalModel {
    final entity = this;

    return EscapeManualTaskLocalModel(
      id: entity.id,
      type: entity.type,
      value: _readTaskValue(entity),
      isDone: entity.isDone,
    );
  }
}

extension ContactEntityMapper on ContactEntity {
  ContactModel get asModel => ContactModel(
        id: id,
        name: name,
        phone: phone,
      );
}

Map<String, dynamic> readUserInputValue(Map map, String key) =>
    <String, dynamic>{
      'type': map['type'] ?? map['tipo'],
      'value': map[key],
    };

dynamic userInputValueFromJson(Map<String, dynamic> json) {
  final value = json['value'];

  if (value == null) return null;
  final type = json['type'] as String;

  switch (type) {
    case escapeManualTaskTypeContacts:
      return ContactModel.fromJsonList(value);
    // coverage:ignore-start
    default: // track if this happens
      logError('Invalid value "$value" for type "$type"');
      return null;
    // coverage:ignore-end
  }
}

Object? _readTaskValue(EscapeManualTaskEntity entity) {
  if (entity is EscapeManualContactsTaskEntity) {
    return entity.value?.map((e) => e.asModel).toList();
  }
  assert(entity is EscapeManualDefaultTaskEntity);
  return null;
}
