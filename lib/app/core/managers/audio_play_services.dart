import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:logger/logger.dart' show Level;
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

typedef OnFinished = void Function();

abstract class IAudioPlayServices {
  Future<Either<Failure, AudioEntity>> start(
    AudioEntity audio, {
    OnFinished? onFinished,
  });
  void dispose();
}

class AudioPlayServices implements IAudioPlayServices {
  AudioPlayServices({required IAudioSyncManager audioSyncManager})
      : _audioSyncManager = audioSyncManager;

  final _audioCodec = Codec.aacADTS;
  late final FlutterSoundPlayer _playerModule =
      FlutterSoundPlayer(logLevel: Level.warning);

  final IAudioSyncManager _audioSyncManager;
  StreamSubscription? _playerSubscription;

  @override
  Future<Either<Failure, AudioEntity>> start(
    AudioEntity audio, {
    OnFinished? onFinished,
  }) async {
    final file = await _audioSyncManager.cache(audio);
    file.fold((l) {}, (file) => play(file, onFinished));
    return file.map((e) => audio);
  }

  @override
  void dispose() {
    cancelPlayerSubscriptions();
    releaseAudioSession();
  }
}

extension _AudioPlayServicesPrivate on AudioPlayServices {
  Future<void> play(File file, OnFinished? onFinished) async {
    await setupPlayEnviroment();
    await _playerModule
        .setSubscriptionDuration(const Duration(milliseconds: 100));

    await _playerModule.startPlayer(
      fromURI: file.path,
      codec: _audioCodec,
      whenFinished: onFinished,
    );
  }

  Future<void> setupPlayEnviroment() async {
    await releaseAudioSession();
    await _playerModule.openAudioSession();

    _playerSubscription = _playerModule.onProgress?.listen((e) {
      // what to do in onProgress?
    });
  }

  Future<void> releaseAudioSession() async {
    try {
      if (!_playerModule.isStopped) {
        await _playerModule.stopPlayer();
      }
      await _playerModule.closeAudioSession();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  void cancelPlayerSubscriptions() {
    _playerSubscription?.cancel();
    _playerSubscription = null;
  }
}
