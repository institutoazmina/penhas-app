import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

typedef OnFinished = void Function();

abstract class IAudioPlayServices {
  Future<Either<Failure, AudioEntity>> start(AudioEntity audio,
      {Function? onFinished});
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

  AudioPlayServices({required IAudioSyncManager audioSyncManager})
      : this._audioSyncManager = audioSyncManager;

  @override
  Future<Either<Failure, AudioEntity>> start(AudioEntity audio,
      {Function? onFinished}) async {
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
  void play(File file, {Function? onFinished}) async {
    await setupPlayEnviroment();
    await _playerModule
        .setSubscriptionDuration(const Duration(milliseconds: 100));

    await _playerModule.startPlayer(
      fromURI: file.path,
      codec: _audioCodec,
      whenFinished: (onFinished as void Function()? ?? {}) as void Function(),
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
    if (_playerSubscription != null) {
      _playerSubscription!.cancel();
      _playerSubscription = null;
    }
  }
}
