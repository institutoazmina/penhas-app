import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

class AudioModel {
  static List<AudioEntity> fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty || json['rows'] == null) {
      return List.empty();
    }

    final rows = json['rows'] as List<dynamic>;
    return rows
        .map((e) => e as Map<String, dynamic>)
        .map((e) => _AudioModelParseData.parseEntity(e))
        .toList();
  }
}

class _AudioModelParseData {
  static AudioEntity parseEntity(Map<String, dynamic> json) {
    final meta = json['meta'] as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;

    final canPlay =
        (int.tryParse(meta['download_granted'].toString()) ?? 0) == 1;
    final isRequested =
        (int.tryParse(meta['requested_by_user'].toString()) ?? 0) == 1;
    final isRequestGranted =
        (int.tryParse(meta['request_granted'].toString()) ?? 0) == 1;
    final id = data['event_id'];
    final createdAt =
        _AudioModelParseData.parseDate(data['last_cliente_created_at'] as String);

    return AudioEntity(
      id: id as String?,
      audioDuration: data['audio_duration'] as String?,
      createdAt: createdAt,
      canPlay: canPlay,
      isRequested: isRequested,
      isRequestGranted: isRequestGranted,
    );
  }

  static DateTime? parseDate(String date) {
    if (!date.endsWith('Z')) {
      date = "${date}Z";
    }
    try {
      return DateTime.parse(date).toLocal();
    } catch (e, stack) {
      logError(e, stack);
      return null;
    }
  }
}
