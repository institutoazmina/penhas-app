import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/shared/logger/log.dart';

import 'audio_sync_manager.dart';

abstract class IAudioPlayServices {
  Future<Either<Failure, AudioEntity>> start(AudioEntity audio,
      {Function? onFinished});
  void dispose();
}

class AudioPlayServices implements IAudioPlayServices {
  final _audioCodec = Codec.aacADTS;
  final FlutterSoundPlayer _playerModule = FlutterSoundPlayer();

  final IAudioSyncManager _audioSyncManager;
  StreamSubscription? _playerSubscription;

  AudioPlayServices({required IAudioSyncManager audioSyncManager})
      : _audioSyncManager = audioSyncManager;

  @override
  Future<Either<Failure, AudioEntity>> start(AudioEntity audio,
      {Function? onFinished}) async {
    final file = await _audioSyncManager.cache(audio);
    file.fold((l) {}, (file) => play(file, onFinished: onFinished));
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
    await _playerModule.setSubscriptionDuration(const Duration(milliseconds: 100));

    await _playerModule.startPlayer(
      fromURI: file.path,
      codec: _audioCodec,
      whenFinished: (onFinished as void Function()? ?? {}) as void Function(),
    );
  }

  Future<void> setupPlayEnviroment() async {
    await releaseAudioSession();
    await _playerModule.openAudioSession();

    _playerModule.onProgress?.listen((e) {
      print(e);
    });
  }

  Future<void> releaseAudioSession() async {
    try {
      await _playerModule.stopPlayer();
      await _playerModule.closeAudioSession();
    } catch (e, stack) {
      logError(e, stack);
      print(e);
    }
  }

  void cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription!.cancel();
      _playerSubscription = null;
    }
  }
}
