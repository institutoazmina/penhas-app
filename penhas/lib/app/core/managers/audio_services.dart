import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:penhas/app/core/states/audio_permission_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import 'audio_sync_manager.dart';

class AudioActivity {
  final String time;
  final double decibels;

  AudioActivity(this.time, this.decibels);
}

abstract class IAudioServices {
  Future<AudioPermissionState> requestPermission();
  Future<AudioPermissionState> permissionStatus();
  Future<void> start();
  Future<void> rotate();
  Stream<AudioActivity> get onProgress;
  // Future<void> stop();
  void dispose();
}

class AudioServices implements IAudioServices {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final IAudioSyncManager _audioSyncManager;
  final _audioCodec = Codec.aacADTS;
  String _currentAudionSession;
  int _sessionSequence;
  Duration _currentDuration = Duration(milliseconds: 0);
  Duration _runningDuration = Duration(milliseconds: 0);

  StreamSubscription _recorderSubscription;
  StreamController<AudioActivity> _streamController =
      StreamController.broadcast();

  String _recordingFile;

  AudioServices({@required IAudioSyncManager audioSyncManager})
      : this._audioSyncManager = audioSyncManager;

  @override
  Stream<AudioActivity> get onProgress => _streamController.stream;

  @override
  Future<void> start() async {
    _sessionSequence = 0;
    _currentAudionSession = Uuid().v4();

    await permissionStatus().then(
      (p) => p.maybeWhen(
          granted: () async => _setupRecordEnviroment(),
          orElse: () => requestPermission()),
    );
  }

  @override
  Future<void> rotate() {
    final currentAudioFile = _recordingFile;
    return _setupRecordEnviroment().then(
      (_) => _audioSyncManager.syncAudio(currentAudioFile),
    );
  }

  @override
  void dispose() {
    _cancelRecorderSubscriptions();
    _releaseAudioSession();
    try {
      if (_streamController != null) {
        _streamController.close();
        _streamController = null;
      }
    } catch (e) {
      print(e);
    }
  }

  void _cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }

    _streamController?.close();
  }

  Future<void> _releaseAudioSession() async {
    try {
      await _recorder.stopRecorder();
      await _recorder.closeAudioSession();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _setupRecordEnviroment() async {
    await _releaseAudioSession();
    await _recorder.openAudioSession(
        focus: AudioFocus.requestFocusAndDuckOthers);

    _currentDuration = Duration(
        milliseconds:
            _currentDuration.inMilliseconds + _runningDuration.inMilliseconds);

    _sessionSequence += 1;
    _audioSyncManager
        .audioFile(
            session: _currentAudionSession,
            sequence: _sessionSequence.toString())
        .then((path) => _recordingFile = path)
        .then((file) => _startRecorder(file));
  }

  Future<void> _startRecorder(String path) async {
    try {
      _recorder.startRecorder(
        codec: _audioCodec,
        toFile: path,
        bitRate: 96000,
        sampleRate: 32000,
      );

      _recorderSubscription = _recorder.onProgress.listen(
        (e) {
          if (e != null && e.duration != null) {
            _runningDuration = e.duration;
            DateTime date = new DateTime.fromMillisecondsSinceEpoch(
                _runningDuration.inMilliseconds +
                    _currentDuration.inMilliseconds,
                isUtc: true);
            String recordTime =
                DateFormat('mm:ss:SS', 'en_GB').format(date).substring(0, 8);
            _streamController.add(AudioActivity(recordTime, e.decibels));
          }
        },
      );
    } catch (err) {
      print('startRecorder error: $err');
      _stopRecorder();
    }
  }

  void _stopRecorder() async {
    try {
      await _recorder.stopRecorder();
      _cancelRecorderSubscriptions();
    } catch (err) {
      print('stopRecorder error: $err');
      _cancelRecorderSubscriptions();
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
        granted: () => AudioPermissionState.granted(),
        denied: () => _requestDeniedPermission(),
        permanentlyDenied: () => _requestDeniedPermission(),
        restricted: () => AudioPermissionState.restricted(),
        undefined: () => _requestPermission(),
      ),
    );
  }

  Future<AudioPermissionState> _requestPermission() {
    return Modular.to
        .showDialog(
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Column(
                children: <Widget>[
                  Icon(
                    Icons.mic_none,
                    color: DesignSystemColors.easterPurple,
                    size: 48,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text('Acesso ao microfone',
                        style: kTextStyleAlertDialogTitle),
                  ),
                ],
              ),
              content: RichText(
                text: TextSpan(
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
                      text: 'deste apareclho?',
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
                  child: Text('Agora não'),
                  onPressed: () async {
                    Modular.to.pop(AudioPermissionState.denied());
                  },
                ),
                SizedBox(
                  width: 120,
                  child: FlatButton(
                    color: DesignSystemColors.easterPurple,
                    child: Text('Sim claro!',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      Permission.microphone
                          .request()
                          .then((value) => value.mapFrom())
                          .then((value) =>
                              _requestDeniedPermissionIfNeeded(value))
                          .then((value) => Modular.to.pop(value));
                    },
                  ),
                ),
              ],
            );
          },
        )
        .then((value) => value as AudioPermissionState)
        .catchError(
          (_) => AudioPermissionState.undefined(),
        );
  }

  Future<AudioPermissionState> _requestDeniedPermissionIfNeeded(
      AudioPermissionState state) async {
    return state.maybeWhen(
      permanentlyDenied: () => _requestDeniedPermission(),
      orElse: () => state,
    );
  }

  Future<AudioPermissionState> _requestDeniedPermission() {
    return Modular.to
        .showDialog(
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Column(
                children: <Widget>[
                  Icon(
                    Icons.mic_off,
                    color: DesignSystemColors.easterPurple,
                    size: 48,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text('Microfone bloqueado',
                        style: kTextStyleAlertDialogTitle),
                  ),
                ],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
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
                      text: TextSpan(
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
                  child: Text('Não'),
                  onPressed: () async {
                    Modular.to.pop(AudioPermissionState.denied());
                  },
                ),
                SizedBox(
                  width: 120,
                  child: FlatButton(
                    color: DesignSystemColors.easterPurple,
                    child: Text('Sim', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      openAppSettings().then(
                        (value) =>
                            Modular.to.pop(AudioPermissionState.undefined()),
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
          (_) => AudioPermissionState.undefined(),
        );
  }
}

extension _PermissionStatusMap on PermissionStatus {
  AudioPermissionState mapFrom() {
    switch (this) {
      case PermissionStatus.denied:
        return AudioPermissionState.denied();
      case PermissionStatus.granted:
        return AudioPermissionState.granted();
      case PermissionStatus.restricted:
        return AudioPermissionState.restricted();
      case PermissionStatus.permanentlyDenied:
        return AudioPermissionState.permanentlyDenied();
      case PermissionStatus.undetermined:
        return AudioPermissionState.undefined();
    }

    return AudioPermissionState.undefined();
  }
}
