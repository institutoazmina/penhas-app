import 'package:flutter/material.dart';

import '../../../../features/feed/domain/entities/tweet_badge_entity.dart';
import '../../colors.dart';
import '../../text_styles.dart';

class UserCloseBadgeWidget extends StatelessWidget {
  const UserCloseBadgeWidget({Key? key, required this.badge}) : super(key: key);

  final TweetBadgeEntity badge;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: badge.popUp == 1 ? () {} : null,
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
                  child: badge.imageUrl.isNotEmpty
                      ? Image.network(
                          badge.imageUrl,
                          width: 12,
                          height: 12,
                        )
                      : const SizedBox.shrink()),
              Text(
                badge.name,
                style: kTextStyleFeedCloseUserTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
