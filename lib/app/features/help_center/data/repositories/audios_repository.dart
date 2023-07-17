import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/logger/log.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../../domain/entities/audio_entity.dart';
import '../models/audio_model.dart';

abstract class IAudiosRepository {
  Future<Either<Failure, List<AudioEntity>?>> fetch();
  Future<Either<Failure, ValidField>> delete(AudioEntity audio);
  Future<Either<Failure, ValidField>> requestAccess(AudioEntity audio);
}

class AudiosRepository implements IAudiosRepository {
  AudiosRepository({
    required IApiProvider? apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider? _apiProvider;

  @override
  Future<Either<Failure, List<AudioEntity>?>> fetch() async {
    final endPoint = ['me', 'audios'].join('/');

    try {
      final response = await _apiProvider!.get(path: endPoint).parseAudios();
      return right(response);
    } catch (error, stack) {
      logError(error, stack);
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
    } catch (error, stack) {
      logError(error, stack);
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
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }
}

extension _FutureExtension<T extends String> on Future<T> {
  Future<List<AudioEntity>> parseAudios() async {
    return then((data) async {
      final jsonData = jsonDecode(data) as Map<String, dynamic>?;
      return AudioModel.fromJson(jsonData);
    });
  }
}
