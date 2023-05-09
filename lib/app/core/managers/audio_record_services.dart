import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:logger/logger.dart' show Level;
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../shared/design_system/colors.dart';
import '../../shared/design_system/text_styles.dart';
import '../../shared/logger/log.dart';
import '../extension/asuka.dart';
import '../states/audio_permission_state.dart';
import 'audio_sync_manager.dart';

class AudioActivity {
  AudioActivity(this.time, this.decibels);

  final String time;
  final double decibels;
}

abstract class IAudioRecordServices {
  Future<AudioPermissionState> requestPermission();

  Future<AudioPermissionState> permissionStatus();

  Future<void> start();

  Future<void> rotate();

  Future<void> stop();

  Stream<AudioActivity> get onProgress;

  Future<void> dispose();

  Future<bool> isPermissionGranted();
}

class AudioRecordServices implements IAudioRecordServices {
  AudioRecordServices({
    required IAudioSyncManager audioSyncManager,
    FlutterSoundRecorder? recorder,
  })  : _audioSyncManager = audioSyncManager,
        _recorder = recorder ?? FlutterSoundRecorder(logLevel: Level.warning);

  final _audioCodec = Codec.aacADTS;
  final FlutterSoundRecorder _recorder;
  final IAudioSyncManager _audioSyncManager;

  late int _sessionSequence;
  String? _currentAudionSession;
  Duration _currentDuration = Duration.zero;
  Duration _runningDuration = Duration.zero;

  StreamSubscription? _recorderSubscription;
  StreamController<AudioActivity>? _streamController =
      StreamController.broadcast();

  @override
  Stream<AudioActivity> get onProgress => _streamController!.stream;

  @override
  Future<void> start() async {
    _sessionSequence = 0;
    _currentAudionSession = const Uuid().v4();
    _streamController ??= StreamController.broadcast();

    final currentPermission = await permissionStatus();
    final hasRecordPermission = currentPermission.maybeWhen(
      granted: () => true,
      orElse: () => false,
    );

    if (hasRecordPermission) {
      await _setupRecordEnvironment();
    } else {
      requestPermission();
    }
  }

  @override
  Future<bool> isPermissionGranted() => Permission.microphone.isGranted;

  @override
  Future<void> stop() async {
    try {
      if (_recorder.isStopped) return;

      await _recorder.stopRecorder();
      await _audioSyncManager.syncAudio();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  @override
  Future<void> rotate() async {
    await _setupRecordEnvironment();
    await _audioSyncManager.syncAudio();
  }

  @override
  Future<void> dispose() async {
    _cancelRecorderSubscriptions();
    await _releaseAudioSession();
    await _audioSyncManager.syncAudio();

    try {
      _streamController?.close();
      _streamController = null;
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  @override
  Future<AudioPermissionState> permissionStatus() async {
    final status = await Permission.microphone.status;
    final mapper = status.mapFrom();

    return mapper;
  }

  @override
  Future<AudioPermissionState> requestPermission() {
    return permissionStatus().then(
      (p) => p.when(
        granted: () => const AudioPermissionState.granted(),
        denied: () => _askForPermission(),
        permanentlyDenied: () => _askWhenPermissionIsDenied(),
        restricted: () => const AudioPermissionState.restricted(),
        undefined: () => _askForPermission(),
      ),
    );
  }
}

extension _PermissionStatusMap on PermissionStatus {
  AudioPermissionState mapFrom() {
    switch (this) {
      case PermissionStatus.denied:
        return const AudioPermissionState.denied();
      case PermissionStatus.granted:
        return const AudioPermissionState.granted();
      case PermissionStatus.restricted:
        return const AudioPermissionState.restricted();
      case PermissionStatus.permanentlyDenied:
        return const AudioPermissionState.permanentlyDenied();
      case PermissionStatus.limited:
        return const AudioPermissionState.undefined();
    }
  }
}

extension _AudioRecordServices on AudioRecordServices {
  void _cancelRecorderSubscriptions() {
    _recorderSubscription?.cancel();
    _recorderSubscription = null;

    _streamController?.close();
  }

  Future<void> _releaseAudioSession() async {
    try {
      final isRecorderStopped = _recorder.isStopped;
      if (!isRecorderStopped) {
        await _recorder.stopRecorder();
      }

      await _recorder.closeRecorder();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  Future<void> _setupRecordEnvironment() async {
    await _releaseAudioSession();
    await _recorder.openRecorder();

    _currentDuration = Duration(
      milliseconds:
          _currentDuration.inMilliseconds + _runningDuration.inMilliseconds,
    );

    _sessionSequence += 1;
    final audioFileName = await _audioSyncManager.audioFile(
      session: _currentAudionSession,
      sequence: _sessionSequence.toString(),
    );

    await _startRecorder(audioFileName);
  }

  Future<void> _startRecorder(String path) async {
    try {
      await _recorder
          .setSubscriptionDuration(const Duration(milliseconds: 100));
      await _recorder.startRecorder(
        codec: _audioCodec,
        toFile: path,
        bitRate: 96000,
        sampleRate: 32000,
      );

      _recorderSubscription = _recorder.onProgress?.listen(
        (e) {
          _runningDuration = e.duration;
          final DateTime date = DateTime.fromMillisecondsSinceEpoch(
            _runningDuration.inMilliseconds + _currentDuration.inMilliseconds,
            isUtc: true,
          );
          final String recordTime =
              DateFormat('mm:ss:SS', 'en_GB').format(date).substring(0, 8);
          _streamController!.add(AudioActivity(recordTime, e.decibels ?? 0));
        },
        onError: catchErrorLogger,
      );
    } catch (err, stack) {
      logError(err, stack);
      _stopRecorder();
    }
  }

  Future<void> _stopRecorder() async {
    try {
      await _recorder.stopRecorder();
      _cancelRecorderSubscriptions();
    } catch (err, stack) {
      logError(err, stack);
      _cancelRecorderSubscriptions();
    }
  }

  Future<AudioPermissionState> _askForPermissionIfNeeded(
    AudioPermissionState state,
  ) async {
    return state.maybeWhen(
      permanentlyDenied: () => _askWhenPermissionIsDenied(),
      orElse: () => state,
    );
  }

  Future<AudioPermissionState> _askForPermission() {
    return Modular.to
        .showDialog(
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Column(
                children: const <Widget>[
                  Icon(
                    Icons.mic_none,
                    color: DesignSystemColors.easterPurple,
                    size: 48,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(
                      'Acesso ao microfone',
                      style: kTextStyleAlertDialogTitle,
                    ),
                  ),
                ],
              ),
              content: RichText(
                text: const TextSpan(
                  text: 'PenhaS precisa ter acesso ao microfone para ',
                  style: kTextStyleAlertDialogDescription,
                  children: [
                    TextSpan(
                      text: 'gravar o áudio',
                      style: kTextStyleAlertDialogDescriptionBold,
                    ),
                    TextSpan(
                      text: '. Você ',
                      style: kTextStyleAlertDialogDescription,
                    ),
                    TextSpan(
                      text: 'autoriza o acesso ao microfone ',
                      style: kTextStyleAlertDialogDescriptionBold,
                    ),
                    TextSpan(
                      text: 'deste aparelho?',
                      style: kTextStyleAlertDialogDescription,
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Agora não'),
                  onPressed: () async {
                    Navigator.of(context)
                        .pop(const AudioPermissionState.denied());
                  },
                ),
                SizedBox(
                  width: 120,
                  child: FlatButton(
                    color: DesignSystemColors.easterPurple,
                    child: const Text(
                      'Sim claro!',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Permission.microphone
                          .request()
                          .then((value) => value.mapFrom())
                          .then((value) => _askForPermissionIfNeeded(value))
                          .then((value) => Navigator.of(context).pop(value));
                    },
                  ),
                ),
              ],
            );
          },
        )
        .then((value) => value as AudioPermissionState)
        .catchError(
      (e, stack) {
        logError(e, stack);
        return const AudioPermissionState.undefined();
      },
    );
  }

  Future<AudioPermissionState> _askWhenPermissionIsDenied() {
    return Modular.to
        .showDialog(
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Column(
                children: const <Widget>[
                  Icon(
                    Icons.mic_off,
                    color: DesignSystemColors.easterPurple,
                    size: 48,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(
                      'Microfone bloqueado',
                      style: kTextStyleAlertDialogTitle,
                    ),
                  ),
                ],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RichText(
                    text: const TextSpan(
                      text: 'O acesso ao ',
                      style: kTextStyleAlertDialogDescription,
                      children: [
                        TextSpan(
                          text: 'microfone está bloqueado',
                          style: kTextStyleAlertDialogDescriptionBold,
                        ),
                        TextSpan(
                          text:
                              '. Agora a autorização precisa ser realizada manualmente.',
                          style: kTextStyleAlertDialogDescription,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Você quer liberar o acesso agora?',
                        style: kTextStyleAlertDialogDescriptionBold,
                      ),
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Não'),
                  onPressed: () async {
                    Navigator.of(context)
                        .pop(const AudioPermissionState.denied());
                  },
                ),
                SizedBox(
                  width: 120,
                  child: FlatButton(
                    color: DesignSystemColors.easterPurple,
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      openAppSettings().then(
                        (value) => Navigator.of(context)
                            .pop(const AudioPermissionState.undefined()),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        )
        .then((value) => value as AudioPermissionState)
        .catchError(
      (e, stack) {
        logError(e, stack);
        return const AudioPermissionState.undefined();
      },
    );
  }
}
