import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/presentation/pages/audio/sound_record_widget.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'audio_record_controller.dart';

class AudioRecordPage extends StatefulWidget {
  const AudioRecordPage({Key key}) : super(key: key);

  @override
  _AudioRecordState createState() => _AudioRecordState();
}

class _AudioRecordState
    extends ModularState<AudioRecordPage, AudioRecordController>
    with SnackBarHandler {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AudioActivity _audioActivity;
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
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
    controller.dispose();
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: SafeArea(
        child: SoundRecordWidget(
          audioActivity: _audioActivity,
          onPressed: () async => controller.stopAudioRecord(),
        ),
      ),
    );
  }
}
