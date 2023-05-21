import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class QuizRequestEntity extends Equatable {
  const QuizRequestEntity({
    required this.sessionId,
    required this.options,
  });

  final String? sessionId;
  final Map<String, String> options;

  @override
  List<Object?> get props => [sessionId!, options];
}
