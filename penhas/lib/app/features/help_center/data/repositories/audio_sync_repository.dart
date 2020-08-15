import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';

abstract class IAudioSyncRepository {
  Future<Either<Failure, ValidField>> upload(AudioData audio);
}

class AudioData {
  final String createdAt;
  final String sequence;
  final String eventId;
  final File media;

  AudioData({
    @required this.createdAt,
    @required this.sequence,
    @required this.eventId,
    @required this.media,
  });
}

class AudioSyncRepository implements IAudioSyncRepository {
  final IApiProvider _apiProvider;

  AudioSyncRepository({
    @required IApiProvider apiProvider,
  }) : this._apiProvider = apiProvider;

  @override
  Future<Either<Failure, ValidField>> upload(AudioData audio) async {
    final fileName = audio.media.name;
    final fileData = http.MultipartFile.fromBytes(
      'media',
      audio.media.readAsBytesSync(),
      filename: fileName,
      contentType: MediaType('audio', 'acc'),
    );

    final fields = {
      'event_id': audio.eventId,
      'event_sequence': audio.sequence,
      'cliente_created_at': audio.createdAt,
      'current_time': DateTime.now().toUtc().toIso8601String(),
    };

    try {
      final result = await _apiProvider
          .upload(path: '/me/audios', file: fileData, fields: fields)
          .parseAPI();
      return right(result);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _FileExtention on File {
  String get name {
    return this?.path?.split(Platform.pathSeparator)?.last;
  }
}

extension _FutureExtension<T extends String> on Future<T> {
  Future<ValidField> parseAPI() async {
    return this.then((data) async {
      final jsonData = jsonDecode(data) as Map<String, Object>;
      return ValidField.fromJson(jsonData);
    });
  }
}
