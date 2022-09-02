import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatChannelCard extends StatelessWidget {
  const ChatChannelCard({
    Key? key,
    required this.channel,
    required this.onPressed,
  }) : super(key: key);

  final ChatChannelEntity channel;
  final void Function(ChatChannelEntity channel) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(channel),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[350]!),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromRGBO(239, 239, 239, 1.0),
                radius: 20,
                child: SvgPicture.network(channel.user.avatar!),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      Text(channel.user.nickname!, style: cardTitleTextStyle),
                      Text(channel.user.activity!, style: cardStatusTextStyle),
                    ],
                  ),
                ),
              ),
              Text(
                transformDate(channel.lastMessageTime!),
                style: cardStatusTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String transformDate(DateTime time) {
    return '${formatWithZero(time.day)}/${formatWithZero(time.month)}/${formatWithZero(time.year)}';
  }

  String formatWithZero(int value) => value > 9 ? '$value' : '0$value';
}

extension _ChatTalkCardPrivate on ChatChannelCard {
  TextStyle get cardTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
  TextStyle get cardStatusTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.warnGrey,
        fontWeight: FontWeight.normal,
      );
}
