import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';
import '../../domain/entities/chat_main_tile_entity.dart';

class ChatAssistantCard extends StatelessWidget {
  const ChatAssistantCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.channel,
    required this.onPressed,
  }) : super(key: key);

  final String? title;
  final Widget icon;
  final String? description;
  final ChatMainSupportTile channel;
  final void Function(ChatMainSupportTile channel) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(channel),
      child: Container(
        height: 83,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: DesignSystemColors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 5.0),
              blurRadius: 1.0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 10),
                child: icon,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      title!,
                      style: titleStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: Text(
                      description!,
                      style: descriptionStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
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
