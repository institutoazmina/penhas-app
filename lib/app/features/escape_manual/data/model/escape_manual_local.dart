import 'escape_manual.dart';

class EscapeManualTaskLocalModel extends EscapeManualTaskModel {
  const EscapeManualTaskLocalModel({
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

  factory EscapeManualTaskLocalModel.fromMap(Map<String, dynamic> map) =>
      EscapeManualTaskLocalModel(
        id: '${map['id']!}',
        type: map['type'],
        group: map['group'],
        title: map['title'],
        description: map['description'],
        isEditable: '${map['is_editable']}' == '1',
        userInputValue: map['user_input_value'],
        isDone: '${map['is_done']}' == '1',
        updatedAt: map['updated_at'],
      );

  static Iterable<EscapeManualTaskLocalModel> fromMapList(
    List<dynamic> map,
  ) =>
      map.map<EscapeManualTaskLocalModel>(
        (task) => EscapeManualTaskLocalModel.fromMap(task),
      );
}