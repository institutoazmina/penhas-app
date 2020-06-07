import 'package:equatable/equatable.dart';

class ValidField extends Equatable {
  final String message;

  ValidField({this.message});

  @override
  List<Object> get props => null;

  @override
  bool get stringify => true;

  factory ValidField.fromJson(Map<String, Object> jsonData) {
    final String message = jsonData['message'];
    return ValidField(message: message);
  }
}

class ValidFieldModel extends ValidField {}
