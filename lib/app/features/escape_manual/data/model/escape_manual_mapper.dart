import 'package:collection/collection.dart';

import '../../domain/entity/escape_manual.dart';
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
              tasks: el.value.map((el) => el.asEntity).toList(),
            ),
          )
          .toList();
}

extension EscapeManualTaskRemoteMapper on EscapeManualTaskRemoteModel {
  /// Maps a [EscapeManualTaskRemoteModel] to a [EscapeManualTaskEntity].
  EscapeManualTaskEntity get asEntity => EscapeManualTaskEntity(
        id: id,
        type: type,
        description: description,
        isEditable: isEditable == true,
        userInputValue: userInputValue,
        isDone: isDone == true,
      );
}
