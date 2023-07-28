import 'package:collection/collection.dart';

import '../../domain/entity/escape_manual.dart';

class EscapeManualTasksSectionModel extends EscapeManualTasksSectionEntity {
  const EscapeManualTasksSectionModel({
    required String title,
    required Iterable<EscapeManualTaskModel> tasks,
  }) : super(title: title, tasks: tasks);

  static Iterable<EscapeManualTasksSectionModel> fromList(
    Iterable<EscapeManualTaskModel> models,
  ) =>
      models.groupListsBy((el) => el.group).entries.map(
            (el) => EscapeManualTasksSectionModel(
              title: el.key,
              tasks: el.value,
            ),
          );
}

class EscapeManualTaskModel extends EscapeManualTaskEntity {
  const EscapeManualTaskModel({
    required String id,
    required String type,
    required String group,
    required String title,
    required String description,
    required bool isEditable,
    required String? userInputValue,
    required bool isDone,
    required int updatedAt,
  }) : super(
          id: id,
          type: type,
          group: group,
          title: title,
          description: description,
          isEditable: isEditable,
          userInputValue: userInputValue,
          isDone: isDone,
          updatedAt: updatedAt,
        );

  factory EscapeManualTaskModel.fromEntity(EscapeManualTaskEntity task) =>
      EscapeManualTaskModel(
        id: task.id,
        type: task.type,
        group: task.group,
        title: task.title,
        description: task.description,
        isEditable: task.isEditable,
        userInputValue: task.userInputValue,
        isDone: task.isDone,
        updatedAt: task.updatedAt,
      );
}
