import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/widgets/badges/user_badge_widget.dart';
import '../../../../shared/design_system/widgets/badges/user_close_badge_widget.dart';
import '../../data/models/chat_user_model.dart';
import '../../domain/entities/chat_badge_entity.dart';
import '../../domain/entities/chat_channel_entity.dart';

class ChatChannelCard extends StatelessWidget {
  const ChatChannelCard({
    super.key,
    required this.channel,
    required this.onPressed,
  });

  final ChatChannelEntity channel;
  final void Function(ChatChannelEntity channel) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(channel),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(239, 239, 239, 1.0),
                radius: 20,
                child: SvgPicture.network(channel.user.avatar!),
              ),
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
                    Row(
                      children: [
                        Text(channel.user.nickname!, style: cardTitleTextStyle),
                        Expanded(
                            flex: 2,
                            child: buildBadgeWidget(channel.user.badges)),
                        Text(
                          transformDate(channel.lastMessageTime!),
                          style: cardStatusTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: setCloseUserPadding(channel.user.badges)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildCloseUser(channel.user.badges),
                        ],
                      ),
                    ),
                    Text(channel.user.activity!, style: cardStatusTextStyle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBadgeWidget(List<ChatBadgeEntity> badges) {
    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }
    var onlyInlineBadges = <ChatBadgeEntity>[];

    for (final badge in badges) {
      if (badge.style != 'inline-block') {
        onlyInlineBadges.add(badge);
      }
    }

    return Row(
      children: onlyInlineBadges
          .map((badge) => Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: UserBadgeWidget(
                badgeDescription: badge.description,
                badgeImageUrl: badge.imageUrlBlack,
                badgeName: badge.name,
                badgePopUp: badge.popUp,
                badgeShowDescription: badge.showDescription,
                isLightBackground: true,
                badgeImageUrlBlack: badge.imageUrlBlack,
              )))
          .toList(),
    );
  }

  double setCloseUserPadding(List<ChatBadgeEntity> badges) {
    return badges.any((badge) => badge.style == 'inline-block') ? 4.0 : 0.0;
  }

  Widget buildCloseUser(List<ChatBadgeEntity> badges) {
    final badge = badges.firstWhere(
      (b) => b.style == 'inline-block',
      orElse: () => ChatBadgeModel(
        code: '',
        description: '',
        imageUrl: '',
        name: '',
        popUp: 0,
        showDescription: 0,
        style: '',
        imageUrlBlack: '',
      ),
    );

    return badge.style.isEmpty
        ? const SizedBox.shrink()
        : UserCloseBadgeWidget(
            badgeImageUrl: badge.imageUrl,
            badgeName: badge.name,
            badgePopUp: badge.popUp,
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
