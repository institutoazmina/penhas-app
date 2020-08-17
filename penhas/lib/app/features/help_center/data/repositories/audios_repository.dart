import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/help_center/data/models/audio_model.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';

abstract class IAudiosRepository {
  Future<Either<Failure, List<AudioEntity>>> fetch();
  Future<Either<Failure, ValidField>> delete(AudioEntity audio);
  Future<Either<Failure, ValidField>> requestAccess(AudioEntity audio);
  Future<Either<Failure, ValidField>> requestAudio(
    AudioEntity audio,
    File file,
  );
}

class AudiosRepository implements IAudiosRepository {
  final IApiProvider _apiProvider;
  final IApiServerConfigure _serverConfiguration;

  AudiosRepository({
    @required IApiProvider apiProvider,
    @required IApiServerConfigure serverConfiguration,
  })  : this._apiProvider = apiProvider,
        this._serverConfiguration = serverConfiguration;

  @override
  Future<Either<Failure, List<AudioEntity>>> fetch() async {
    final endPoint = ['me', 'audios'].join('/');
    final apiKey = await _serverConfiguration.apiToken;
    final baseUri = _serverConfiguration.baseUri.replace(
      path: endPoint,
      queryParameters: {
        'api_key': apiKey,
        'audio_sequences': 'all',
      },
    );

    try {
      final response =
          await _apiProvider.get(path: endPoint).parseAudios(baseUri);
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> delete(AudioEntity audio) async {
    final endPoint = ['me', 'audios', audio.id].join('/');

    try {
      final response =
          await _apiProvider.delete(path: endPoint).parseValidField();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> requestAccess(AudioEntity audio) async {
    final endPoint = ['me', 'audios', audio.id].join('/');

    try {
      final response =
          await _apiProvider.post(path: endPoint).parseValidField();
      return right(response);
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> requestAudio(
      AudioEntity audio, File file) async {
    final endPoint = ['me', 'audios', audio.id, 'download'].join('/');
    final fields = {'audio_sequences': 'all'};
    try {
      await _apiProvider.download(
        path: endPoint,
        file: file,
        fields: fields,
      );
      return right(ValidField());
    } catch (error) {
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _FutureExtension<T extends String> on Future<T> {
  Future<List<AudioEntity>> parseAudios(Uri baseUri) async {
    return this.then((data) async {
      final jsonData = jsonDecode(data) as Map<String, Object>;
      return AudioModel.fromJson(jsonData, baseUri);
    });
  }

  Future<ValidField> parseValidField() async {
    return this.then((data) async {
      try {
        final jsonData = jsonDecode(data) as Map<String, Object>;
        return ValidField.fromJson(jsonData);
      } catch (e) {
        return ValidField();
      }
    });
  }
}
