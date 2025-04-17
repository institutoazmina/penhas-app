import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/widgets/badges/user_badge_widget.dart';
import '../../../../shared/design_system/widgets/badges/user_close_badge_widget.dart';
import '../../../users/data/models/user_detail_profile_model.dart';
import '../../../users/domain/entities/user_detail_badge_entity.dart';
import '../../../users/domain/entities/user_detail_profile_entity.dart';

class ChatPeopleCard extends StatelessWidget {
  const ChatPeopleCard({
    super.key,
    required this.person,
    required this.onPressed,
  });

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
                          buildBadgeWidget(person.badges),
                        ],
                      ),
                      person.badges.isNotEmpty
                          ? Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: setCloseUserPadding(person.badges)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    buildCloseUser(person.badges),
                                  ],
                                ),
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

  Widget buildBadgeWidget(List<UserDetailBadgeEntity> badges) {
    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }
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
                isLightBackground: true,
              )))
          .toList(),
    );
  }
}

double setCloseUserPadding(List<UserDetailBadgeEntity> badges) {
  return badges.any((badge) => badge.style == 'inline-block') ? 6.0 : 0.0;
}

Widget buildCloseUser(List<UserDetailBadgeEntity> badges) {
  if (badges.isEmpty) {
    return const SizedBox.shrink();
  }
  final emptyBadge = UserDetailBadgeModel(
      code: '',
      description: '',
      imageUrl: '',
      name: '',
      popUp: 0,
      showDescription: 0,
      style: '');
  final badge = badges.firstWhere(
    (badge) => badge.style == 'inline-block',
    orElse: () => emptyBadge,
  );
  if (badge.style.isEmpty) {
    return const SizedBox.shrink();
  }

  return UserCloseBadgeWidget(
    badgeImageUrl: badge.imageUrl,
    badgeName: badge.name,
    badgePopUp: badge.popUp,
  );
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
