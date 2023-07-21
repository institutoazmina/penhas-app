import 'package:flutter/material.dart';

import '../../../../../core/managers/audio_record_services.dart';
import '../../../../../shared/design_system/colors.dart';

class SoundRecordWidget extends StatefulWidget {
  const SoundRecordWidget({Key? key, this.audioActivity, this.onPressed})
      : super(key: key);

  final AudioActivity? audioActivity;
  final VoidCallback? onPressed;

  @override
  _SoundRecordWidgetState createState() => _SoundRecordWidgetState();
}

class _SoundRecordWidgetState extends State<SoundRecordWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2));
  late Animation _animation;

  @override
  void initState() {
    _animation = Tween(begin: 0.0, end: 12.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
      child: InkWell(
        onTap: () => widget.onPressed?.call(),
        child: Ink(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DesignSystemColors.easterPurple,
            boxShadow: [
              for (int i = 1; i <= 5; i++)
                BoxShadow(
                  color: DesignSystemColors.easterPurple
                      .withOpacity(_animationController.value / 2),
                  spreadRadius: i * _animation.value as double,
                )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.mic,
                color: Colors.white,
                size: 42,
              ),
              Text(
                widget.audioActivity?.time ?? '',
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 35.0,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
