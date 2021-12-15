import 'package:equatable/equatable.dart';

class AlertModel extends Equatable {
  const AlertModel({
    required this.title,
    required this.message,
  });

  final String? title;
  final String? message;

  static AlertModel fromJson(Map<String, dynamic> json) {
    return AlertModel(
      title: json['title'],
      message: json['message'] ?? json['text'],
    );
  }

  final String? title;
  final String? message;

  @override
  List<dynamic> get props => [title, message];
}
