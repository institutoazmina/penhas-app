import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AudioEntity extends Equatable {
  const AudioEntity({
    required this.id,
    required this.audioDuration,
    required this.createdAt,
    required this.canPlay,
    required this.isRequested,
    required this.isRequestGranted,
  });

  final String? id;
  final String? audioDuration;
  final DateTime? createdAt;
  final bool canPlay;
  final bool isRequested;
  final bool isRequestGranted;

  @override
  List<Object?> get props => [
        id!,
        audioDuration!,
        createdAt!,
        canPlay,
        isRequested,
        isRequestGranted,
      ];

  @override
  bool get stringify => true;
}
