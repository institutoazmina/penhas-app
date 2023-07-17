import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/managers/audio_record_services.dart';
import '../../../../../shared/design_system/colors.dart';
import '../../../../authentication/presentation/shared/snack_bar_handler.dart';
import 'audio_record_controller.dart';
import 'sound_record_widget.dart';

class AudioRecordPage extends StatefulWidget {
  const AudioRecordPage({Key? key}) : super(key: key);

  @override
  _AudioRecordState createState() => _AudioRecordState();
}

class _AudioRecordState
    extends ModularState<AudioRecordPage, AudioRecordController>
    with SnackBarHandler {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AudioActivity? _audioActivity;
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await controller.startAudioRecord();
    });

    _streamSubscription = controller.audioActivity.listen((event) {
      setState(() {
        _audioActivity = event;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.stopAudioRecord();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: DesignSystemColors.ligthPurple,
        ),
        body: SoundRecordWidget(
          audioActivity: _audioActivity,
          onPressed: () async => controller.stopAudioRecord(),
        ),
      ),
    );
  }
}
