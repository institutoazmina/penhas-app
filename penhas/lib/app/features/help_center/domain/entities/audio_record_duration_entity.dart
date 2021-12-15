import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AudioRecordDurationEntity extends Equatable {
  /// audioEachDuration define quando tempo cada 'slot' de gravação deve durar
  final int audioEachDuration;

  /// audioFullDuration define o total de tempo que deve durar a sessão de gravação
  final int audioFullDuration;

  const AudioRecordDurationEntity(this.audioEachDuration, this.audioFullDuration);

  @override
  List<Object?> get props => [audioEachDuration, audioFullDuration];
}
