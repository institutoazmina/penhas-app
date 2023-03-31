import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:logger/logger.dart' show Level;

import '../../features/help_center/domain/entities/audio_entity.dart';
import '../../shared/logger/log.dart';
import '../error/failures.dart';
import 'audio_sync_manager.dart';

typedef OnFinished = void Function();

abstract class IAudioPlayServices {
  Future<Either<Failure, AudioEntity>> start(
    AudioEntity audio, {
    OnFinished? onFinished,
  });

  Future<void> dispose();
}

class AudioPlayServices implements IAudioPlayServices {
  AudioPlayServices({
    required IAudioSyncManager audioSyncManager,
    FlutterSoundPlayer? player,
  })  : _audioSyncManager = audioSyncManager,
        _playerModule = player ?? FlutterSoundPlayer(logLevel: Level.warning);

  final FlutterSoundPlayer _playerModule;
  final IAudioSyncManager _audioSyncManager;
  StreamSubscription? _playerSubscription;

  final _audioCodec = Codec.aacADTS;

  @override
  Future<Either<Failure, AudioEntity>> start(
    AudioEntity audio, {
    OnFinished? onFinished,
  }) async {
    final file = await _audioSyncManager.cache(audio);
    file.fold((l) {}, (file) => _play(file, onFinished));
    return file.map((e) => audio);
  }

  @override
  Future<void> dispose() async {
    _cancelPlayerSubscriptions();
    await _releaseAudioSession();
  }

  Future<void> _play(File file, OnFinished? onFinished) async {
    await _setupPlayEnvironment();
    await _playerModule
        .setSubscriptionDuration(const Duration(milliseconds: 100));

    await _playerModule.startPlayer(
      fromURI: file.path,
      codec: _audioCodec,
      whenFinished: onFinished,
    );
  }

  Future<void> _setupPlayEnvironment() async {
    await _releaseAudioSession();
    await _playerModule.openPlayer();

    _playerSubscription = _playerModule.onProgress?.listen((e) {
      // what to do in onProgress?
    });
  }

  Future<void> _releaseAudioSession() async {
    try {
      if (!_playerModule.isStopped) {
        await _playerModule.stopPlayer();
      }
      await _playerModule.closePlayer();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  void _cancelPlayerSubscriptions() {
    _playerSubscription?.cancel();
    _playerSubscription = null;
  }
}
