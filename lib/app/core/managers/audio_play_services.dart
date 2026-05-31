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
      codec: _detectCodec(file),
      whenFinished: onFinished,
    );
  }

  /// The recorder normally writes AAC ADTS, but on devices where ADTS recording
  /// fails it falls back to AAC MP4 (PALLIATIVE_FIX_20260523 in
  /// [AudioRecordServices]) — both end up in a file named `.aac`, and the
  /// downloaded copy is cached as `{id}.cached`, so the extension carries no
  /// codec hint. Decoding an MP4 container as ADTS yields garbled/silent
  /// playback, so sniff the container from the file header instead of trusting
  /// a fixed codec. Falls back to [_audioCodec] when the bytes are unreadable
  /// or inconclusive.
  Codec _detectCodec(File file) {
    try {
      final raf = file.openSync();
      final List<int> header;
      try {
        header = raf.readSync(12);
      } finally {
        raf.closeSync();
      }

      // ISO-BMFF (MP4/M4A): 'ftyp' box type at byte offset 4.
      if (header.length >= 8 &&
          header[4] == 0x66 && // f
          header[5] == 0x74 && // t
          header[6] == 0x79 && // y
          header[7] == 0x70) {
        return Codec.aacMP4;
      }

      // AAC ADTS: 12-bit sync word 0xFFF at the start of the stream.
      if (header.length >= 2 &&
          header[0] == 0xFF &&
          (header[1] & 0xF6) == 0xF0) {
        return Codec.aacADTS;
      }
    } catch (e, stack) {
      logError(e, stack);
    }

    return _audioCodec;
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
