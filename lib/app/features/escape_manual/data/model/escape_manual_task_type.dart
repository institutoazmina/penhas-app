import 'package:freezed_annotation/freezed_annotation.dart';

const escapeManualTaskTypeNormal = 'checkbox';
const escapeManualTaskTypeContacts = 'checkbox_contato';
const escapeManualTaskTypeButton = 'button';

enum EscapeManualTaskType {
  unknown,
  @JsonValue(escapeManualTaskTypeNormal)
  normal,
  @JsonValue(escapeManualTaskTypeContacts)
  contacts,
  @JsonValue(escapeManualTaskTypeButton)
  button,
}
