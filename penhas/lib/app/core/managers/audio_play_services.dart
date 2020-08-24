import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';

import 'audio_sync_manager.dart';

abstract class IAudioPlayServices {
  Future<Either<Failure, ValidField>> start(AudioEntity audio);
  void dispose();
}

class AudioPlayServices implements IAudioPlayServices {
  final _audioCodec = Codec.aacADTS;
  FlutterSoundPlayer _playerModule = FlutterSoundPlayer();

  final IAudioSyncManager _audioSyncManager;
  StreamSubscription _playerSubscription;

  AudioPlayServices({@required IAudioSyncManager audioSyncManager})
      : this._audioSyncManager = audioSyncManager;

  @override
  Future<Either<Failure, ValidField>> start(AudioEntity audio) async {
    final foo = await _audioSyncManager.cache(audio);
    foo.fold((l) {}, (file) => play(file));
  }

  @override
  void dispose() {
    cancelPlayerSubscriptions();
    releaseAudioSession();
  }
}

extension _AudioPlayServicesPrivate on AudioPlayServices {
  void play(File file) async {
    await setupPlayEnviroment();
    await _playerModule.setSubscriptionDuration(Duration(milliseconds: 100));

    await _playerModule.startPlayer(
      fromURI: file.path,
      codec: _audioCodec,
      whenFinished: () => print('Ola mundo cruel!'),
    );
  }

  Future<void> setupPlayEnviroment() async {
    await releaseAudioSession();
    await _playerModule.openAudioSession();

    _playerModule.onProgress.listen((e) {
      print(e);
    });
  }

  Future<void> releaseAudioSession() async {
    try {
      await _playerModule.stopPlayer();
      await _playerModule.closeAudioSession();
    } catch (e) {
      print(e);
    }
  }

  void cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription.cancel();
      _playerSubscription = null;
    }
  }
}
