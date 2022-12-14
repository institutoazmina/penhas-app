import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:logger/logger.dart' show Level;
import 'package:penhas/app/core/extension/asuka.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/core/states/audio_permission_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:penhas/app/shared/logger/log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

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

  void dispose();
}

class AudioRecordServices implements IAudioRecordServices {
  AudioRecordServices({required IAudioSyncManager audioSyncManager})
      : _audioSyncManager = audioSyncManager;

  late final FlutterSoundRecorder _recorder =
      FlutterSoundRecorder(logLevel: Level.warning);
  final IAudioSyncManager _audioSyncManager;
  final _audioCodec = Codec.aacADTS;
  String? _currentAudionSession;
  late int _sessionSequence;
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

    await permissionStatus().then(
      (p) => p.maybeWhen(
        granted: () async => _setupRecordEnviroment(),
        orElse: () => requestPermission(),
      ),
    );
  }

  @override
  Future<void> stop() async {
    try {
      if (_recorder.isStopped) return;
      await _recorder
          .stopRecorder()
          .then((value) => _audioSyncManager.syncAudio());
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  @override
  Future<void> rotate() {
    return _setupRecordEnviroment().then(
      (_) => _audioSyncManager.syncAudio(),
    );
  }

  @override
  void dispose() {
    _cancelRecorderSubscriptions();
    _releaseAudioSession();
    _audioSyncManager.syncAudio();

    try {
      _streamController?.close();
      _streamController = null;
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  @override
  Future<AudioPermissionState> permissionStatus() {
    return Permission.microphone.status.then((value) => value.mapFrom());
  }

  @override
  Future<AudioPermissionState> requestPermission() {
    return permissionStatus().then(
      (p) => p.when(
        granted: () => const AudioPermissionState.granted(),
        denied: () => askForPermission(),
        permanentlyDenied: () => askWhenPermissionIsDenied(),
        restricted: () => const AudioPermissionState.restricted(),
        undefined: () => askForPermission(),
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
      if (!_recorder.isStopped) {
        await _recorder.stopRecorder();
      }
      await _recorder.closeRecorder();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  Future<void> _setupRecordEnviroment() async {
    await _releaseAudioSession();
    await _recorder.openRecorder();

    _currentDuration = Duration(
      milliseconds:
          _currentDuration.inMilliseconds + _runningDuration.inMilliseconds,
    );

    _sessionSequence += 1;
    _audioSyncManager
        .audioFile(
          session: _currentAudionSession,
          sequence: _sessionSequence.toString(),
        )
        .then((file) => _startRecorder(file));
  }

  Future<void> _startRecorder(String path) async {
    try {
      _recorder.setSubscriptionDuration(const Duration(milliseconds: 100));
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

  Future<AudioPermissionState> askForPermissionIfNeeded(
    AudioPermissionState state,
  ) async {
    return state.maybeWhen(
      permanentlyDenied: () => askWhenPermissionIsDenied(),
      orElse: () => state,
    );
  }

  Future<AudioPermissionState> askForPermission() {
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
                      text: 'gravar o ??udio',
                      style: kTextStyleAlertDialogDescriptionBold,
                    ),
                    TextSpan(
                      text: '. Voc?? ',
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
                  child: const Text('Agora n??o'),
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
                          .then((value) => askForPermissionIfNeeded(value))
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

  Future<AudioPermissionState> askWhenPermissionIsDenied() {
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
                          text: 'microfone est?? bloqueado',
                          style: kTextStyleAlertDialogDescriptionBold,
                        ),
                        TextSpan(
                          text:
                              '. Agora a autoriza????o precisa ser realizada manualmente.',
                          style: kTextStyleAlertDialogDescription,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Voc?? quer liberar o acesso agora?',
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
                  child: const Text('N??o'),
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
