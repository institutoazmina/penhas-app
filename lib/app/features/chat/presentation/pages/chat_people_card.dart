import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/widgets/badges/user_badge_widget.dart';
import '../../../../shared/design_system/widgets/badges/user_close_badge_widget.dart';
import '../../../users/domain/entities/user_detail_badge_entity.dart';
import '../../../users/domain/entities/user_detail_profile_entity.dart';

class ChatPeopleCard extends StatelessWidget {
  const ChatPeopleCard({
    Key? key,
    required this.person,
    required this.onPressed,
  }) : super(key: key);

  final UserDetailProfileEntity person;
  final void Function(UserDetailProfileEntity person) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(person),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: DesignSystemColors.white,
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
                child: SvgPicture.network(person.avatar!),
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
                          Text(person.nickname!, style: cardTitleTextStyle),
                          _buildBadgeWidget(person.badges),
                        ],
                      ),
                      person.badges != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildCloseUser(person.badges),
                                ],
                              ),
                            )
                          : Text(person.activity!, style: cardStatusTextStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeWidget(List<UserDetailBadgeEntity>? badges) {
    if (badges == null) {
      return const SizedBox.shrink();
    } else {
      var onlyInlineBadges = <UserDetailBadgeEntity>[];

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
                  badgeImageUrl: badge.imageUrl,
                  badgeName: badge.name,
                  badgePopUp: badge.popUp,
                  badgeShowDescription: badge.showDescription,
                )))
            .toList(),
      );
    }
  }
}

Widget _buildCloseUser(List<UserDetailBadgeEntity>? badges) {
  if (badges == null) {
    return const SizedBox.shrink();
  } else {
    var _emptyBadge = UserDetailBadgeEntity(
        code: '',
        description: '',
        imageUrl: '',
        name: '',
        popUp: 0,
        showDescription: 0,
        style: '');
    final badge = badges.firstWhere(
      (badge) => badge.style == 'inline-block',
      orElse: () => _emptyBadge,
    );
    if (badge.style != '') {
      return UserCloseBadgeWidget(
        badgeImageUrl: badge.imageUrl,
        badgeName: badge.name,
        badgePopUp: badge.popUp,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

extension _ChatTalkCardPrivate on ChatPeopleCard {
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
