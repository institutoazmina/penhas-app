import 'package:flutter/material.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_main_tile_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatAssistantCard extends StatelessWidget {
  final String? title;
  final Widget icon;
  final String? description;
  final ChatMainSupportTile channel;
  final void Function(ChatMainSupportTile channel) onPressed;

  const ChatAssistantCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.channel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(channel),
      child: Container(
        height: 175,
        width: 155,
        decoration: const BoxDecoration(
          color: DesignSystemColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0),
              blurRadius: 8.0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12.0),
          child: Column(
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Text(
                  title!,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                description!,
                style: descriptionStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension _ChatTalkCardPrivate on ChatAssistantCard {
  TextStyle get titleStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
  TextStyle get descriptionStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        height: 1.3,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}
