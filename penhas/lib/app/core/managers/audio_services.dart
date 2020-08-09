import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:penhas/app/core/states/audio_permission_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class IAudioServices {
  Future<AudioPermissionState> requestPermission();
  Future<AudioPermissionState> permissionStatus();
  Future<void> start();
  // Future<void> stop();
  void dispose();
}

class AudioServices implements IAudioServices {
  FlutterSoundRecorder _recorderModule = FlutterSoundRecorder();

  @override
  Future<void> start() async {
    await _recorderModule.setSubscriptionDuration(Duration(milliseconds: 10));
      Directory tempDir = await getTemporaryDirectory();

    
    await _recorderModule.startRecorder(toFile: );
  }

  @override
  void dispose() {
    _releaseAudioSession();
  }

  Future<void> _releaseAudioSession() async {
    try {
      await _recorderModule.closeAudioSession();
    } catch (e) {}
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

  //   void cancelRecorderSubscriptions() {
  //   if (_recorderSubscription != null) {
  //     _recorderSubscription.cancel();
  //     _recorderSubscription = null;
  //   }
  //    }

  // void cancelPlayerSubscriptions() {
  //   if (_playerSubscription != null) {
  //     _playerSubscription.cancel();
  //     _playerSubscription = null;
  //   }
  // }

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

extension PermissionStatusMap on PermissionStatus {
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
