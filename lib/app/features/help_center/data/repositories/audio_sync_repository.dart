import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/logger/log.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../../domain/entities/audio_entity.dart';

abstract class IAudioSyncRepository {
  Future<Either<Failure, ValidField>> download(AudioEntity audio, File file);
}

class AudioSyncRepository implements IAudioSyncRepository {
  AudioSyncRepository({
    required IApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  Future<Either<Failure, ValidField>> download(
    AudioEntity audio,
    File file,
  ) async {
    final endPoint = ['me', 'audios', audio.id, 'download'].join('/');
    final fields = {'audio_sequences': 'all'};
    try {
      await _apiProvider.download(
        path: endPoint,
        file: file,
        fields: fields,
      );
      return right(const ValidField());
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }
}
