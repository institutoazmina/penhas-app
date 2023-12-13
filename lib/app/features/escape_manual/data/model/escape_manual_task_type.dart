import 'package:freezed_annotation/freezed_annotation.dart';

const escapeManualTaskTypeNormal = 'checkbox';
const escapeManualTaskTypeContacts = 'checkbox_contato';

enum EscapeManualTaskType {
  @JsonValue(escapeManualTaskTypeNormal)
  normal,
  @JsonValue(escapeManualTaskTypeContacts)
  contacts,
  unknown
}
