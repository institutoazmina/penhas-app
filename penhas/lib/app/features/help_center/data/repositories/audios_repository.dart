import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:penhas/app/features/help_center/data/models/audio_model.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

abstract class IAudiosRepository {
  Future<Either<Failure, List<AudioEntity>?>> fetch();
  Future<Either<Failure, ValidField>> delete(AudioEntity audio);
  Future<Either<Failure, ValidField>> requestAccess(AudioEntity audio);
}

class AudiosRepository implements IAudiosRepository {
  final IApiProvider? _apiProvider;

  AudiosRepository({
    required IApiProvider? apiProvider,
  }) : this._apiProvider = apiProvider;

  @override
  Future<Either<Failure, List<AudioEntity>?>> fetch() async {
    final endPoint = ['me', 'audios'].join('/');

    try {
      final response = await _apiProvider!.get(path: endPoint).parseAudios();
      return right(response);
    } catch (error) {
      logError(error);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> delete(AudioEntity audio) async {
    final endPoint = ['me', 'audios', audio.id].join('/');

    try {
      final response =
          await _apiProvider!.delete(path: endPoint).parseValidField();
      return right(response);
    } catch (error) {
      logError(error);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, ValidField>> requestAccess(AudioEntity audio) async {
    final endPoint = ['me', 'audios', audio.id, 'request-access'].join('/');

    try {
      final response =
          await _apiProvider!.post(path: endPoint).parseValidField();
      return right(response);
    } catch (error) {
      logError(error);
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _FutureExtension<T extends String> on Future<T> {
  Future<List<AudioEntity>> parseAudios() async {
    return this.then((data) async {
      final jsonData = jsonDecode(data) as Map<String, Object>?;
      return AudioModel.fromJson(jsonData);
    });
  }
}
