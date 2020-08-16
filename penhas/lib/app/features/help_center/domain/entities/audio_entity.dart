import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class AudioEntity extends Equatable {
  final String id;
  final String audioDuration;
  final DateTime createdAt;
  final Uri path;
  final bool canPlay;
  final bool isRequested;
  final bool isRequestGranted;

  AudioEntity({
    @required this.id,
    @required this.audioDuration,
    @required this.path,
    @required this.createdAt,
    @required this.canPlay,
    @required this.isRequested,
    @required this.isRequestGranted,
  });

  @override
  List<Object> get props => [
        id,
        audioDuration,
        createdAt,
        path,
        canPlay,
        isRequested,
        isRequestGranted,
      ];

  @override
  bool get stringify => true;
}
