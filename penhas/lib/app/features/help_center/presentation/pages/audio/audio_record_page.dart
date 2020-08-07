import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
    );
  }
}
