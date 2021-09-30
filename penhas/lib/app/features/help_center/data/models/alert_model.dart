import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AlertModel extends Equatable {
  AlertModel({
    @required this.title,
    @required this.message,
  });

  final String title;
  final String message;

  static AlertModel fromJson(Map<String, dynamic> json) {
    return AlertModel(
      title: json['title'],
      message: json['message'] ?? json['text'],
    );
  }

  @override
  List<Object> get props => [title, message];
}
