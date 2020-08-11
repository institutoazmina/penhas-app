import 'package:flutter/material.dart';
import 'package:penhas/app/core/managers/audio_services.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SoundRecordWidget extends StatefulWidget {
  final AudioActivity audioActivity;
  final VoidCallback onPressed;
  SoundRecordWidget({Key key, this.audioActivity, this.onPressed})
      : super(key: key);

  @override
  _SoundRecordWidgetState createState() => _SoundRecordWidgetState();
}

class _SoundRecordWidgetState extends State<SoundRecordWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
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
      child: GestureDetector(
        onTap: () => widget.onPressed?.call(),
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
      ),
    );
  }
}
