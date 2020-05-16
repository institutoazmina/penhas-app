import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class QuizRequestEntity extends Equatable {
  final int sessionId;
  final Map<String, String> options;

  QuizRequestEntity({
    @required this.sessionId,
    @required this.options,
  });

  @override
  List<Object> get props => [sessionId, options];
}
