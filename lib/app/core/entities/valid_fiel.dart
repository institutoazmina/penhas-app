import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:penhas/app/shared/logger/log.dart';

class ValidField extends Equatable {
  const ValidField({this.message});

  factory ValidField.fromJson(Map<String, dynamic> jsonData) {
    final String? message = jsonData['message'] ?? jsonData['text'];
    return ValidField(message: message);
  }

  final String? message;

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class ValidFieldModel extends ValidField {}

extension ValidFieldFutureExtension<T extends String> on Future<T> {
  Future<ValidField> parseValidField() async {
    return then((data) async {
      try {
        final jsonData = jsonDecode(data) as Map<String, dynamic>;
        return ValidField.fromJson(jsonData);
      } catch (e, stack) {
        logError(e, stack);
        return const ValidField();
      }
    });
  }
}
