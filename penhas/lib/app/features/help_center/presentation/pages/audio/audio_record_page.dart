import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/managers/audio_services.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
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
        child: GlossAnimated(
          audioActivity: _audioActivity,
        ),
      ),
    );
  }
}

class GlossAnimated extends StatefulWidget {
  final AudioActivity audioActivity;
  GlossAnimated({Key key, this.audioActivity}) : super(key: key);

  @override
  _GlossAnimatedState createState() => _GlossAnimatedState();
}

class _GlossAnimatedState extends State<GlossAnimated>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _animationController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DesignSystemColors.easterPurple,
            boxShadow: [
              BoxShadow(
                color: DesignSystemColors.easterPurple,
                blurRadius: widget?.audioActivity?.decibels?.abs() ?? 2.0,
                spreadRadius: widget?.audioActivity?.decibels?.abs() ?? 2.0,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.mic,
              color: Colors.white,
              size: 42,
            ),
            Text(
              widget.audioActivity?.time ?? '',
              style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 35.0,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
