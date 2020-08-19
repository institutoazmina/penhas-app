import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_play_tile_entity.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class AudioPlayWidget extends StatelessWidget {
  final AudioPlayTileEntity audioPlay;
  const AudioPlayWidget({Key key, @required this.audioPlay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[350]),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.play_circle_filled,
                        size: 40,
                      ),
                      onPressed: () => audioPlay.playAudio(audioPlay.audio)),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      audioPlay.audio.audioDuration,
                      style: kTextStyleAudioDuration,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat.yMd('pt_BR')
                              .format(audioPlay.audio.createdAt),
                          style: kTextStyleAudioTime,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Text(audioPlay.description,
                      style: kTextStyleAudioDescription),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 44,
              width: 44,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => audioPlay.action(audioPlay.audio),
              ),
            ),
          )
        ],
      ),
    );
  }
}
