import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class QuizRequestEntity extends Equatable {
  final String? sessionId;
  final Map<String, String> options;

  QuizRequestEntity({
    required this.sessionId,
    required this.options,
  });

  final String? sessionId;
  final Map<String, String> options;

  @override
  List<Object> get props => [sessionId!, options];

  @override
  bool get stringify => true;
}
