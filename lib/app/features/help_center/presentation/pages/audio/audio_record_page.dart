import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/managers/audio_record_services.dart';
import '../../../../../shared/design_system/colors.dart';
import '../../../../authentication/presentation/shared/snack_bar_handler.dart';
import 'audio_record_controller.dart';
import 'sound_record_widget.dart';

class AudioRecordPage extends StatefulWidget {
  const AudioRecordPage({
    super.key,
    required this.controller,
  });

  final AudioRecordController controller;

  @override
  AudioRecordState createState() => AudioRecordState();
}

class AudioRecordState extends State<AudioRecordPage> with SnackBarHandler {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AudioActivity? _audioActivity;
  StreamSubscription? _streamSubscription;
  AudioRecordController get controller => widget.controller;

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
    _streamSubscription?.cancel();
    _streamSubscription = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        controller.stopAudioRecord();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: DesignSystemColors.ligthPurple,
          foregroundColor: DesignSystemColors.white,
        ),
        body: SoundRecordWidget(
          audioActivity: _audioActivity,
          onPressed: () async => controller.stopAudioRecord(),
        ),
      ),
    );
  }
}
