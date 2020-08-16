import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';

class AudioModel {
  static List<AudioEntity> fromJson(Map<String, Object> json, Uri baseUri) {
    if (json == null || json.isEmpty || json['rows'] == null) {
      return List<AudioEntity>();
    }

    final rows = json['rows'] as List<Object>;
    return rows
        .map((e) => e as Map<String, Object>)
        .map((e) => _AudioModelParseData.parseEntity(e, baseUri))
        .toList();
  }
}

class _AudioModelParseData {
  static AudioEntity parseEntity(Map<String, Object> json, Uri baseUri) {
    final meta = json['meta'] as Map<String, Object>;
    final data = json['data'] as Map<String, Object>;

    final canPlay =
        (int.tryParse(meta['download_granted'].toString()) ?? 0) == 1;
    final isRequested =
        (int.tryParse(meta['requested_by_user'].toString()) ?? 0) == 1;
    final isRequestGranted =
        (int.tryParse(meta['request_granted'].toString()) ?? 0) == 1;
    final id = data['event_id'];
    final createdAt =
        _AudioModelParseData.parseDate(data['last_cliente_created_at']);

    Uri audioUri;
    if (canPlay) {
      List<String> endPointList = baseUri.path.split('/');
      endPointList.retainWhere((e) => e.isNotEmpty);
      endPointList.addAll([id, 'download']);
      final endPointPath = endPointList.join('/');
      audioUri = baseUri.replace(path: endPointPath);
    }

    return AudioEntity(
      id: id,
      audioDuration: data['audio_duration'],
      path: audioUri,
      createdAt: createdAt,
      canPlay: canPlay,
      isRequested: isRequested,
      isRequestGranted: isRequestGranted,
    );
  }

  static DateTime parseDate(String date) {
    if (!date.endsWith('Z')) {
      date = "${date}Z";
    }
    try {
      return DateTime.parse(date).toLocal();
    } catch (e) {
      return null;
    }
  }
}
