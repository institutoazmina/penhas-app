import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../colors.dart';
import '../../text_styles.dart';

class UserCloseBadgeWidget extends StatelessWidget {
  const UserCloseBadgeWidget(
      {Key? key,
      required this.badgePopUp,
      required this.badgeImageUrl,
      required this.badgeName})
      : super(key: key);

  final int badgePopUp;
  final String badgeImageUrl;
  final String badgeName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: badgePopUp == 1 ? () {} : null,
      child: Container(
        decoration: BoxDecoration(
            color: DesignSystemColors.ligthPurple2,
            borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 6.0, bottom: 6.0),
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: badgeImageUrl.isNotEmpty
                      ? SvgPicture.network(
                          badgeImageUrl,
                          width: 12,
                          height: 12,
                          colorFilter: const ColorFilter.mode(
                              DesignSystemColors.darkIndigoThree,
                              BlendMode.color),
                        )
                      : const SizedBox.shrink()),
              Text(
                badgeName,
                style: kTextStyleFeedCloseUserTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
