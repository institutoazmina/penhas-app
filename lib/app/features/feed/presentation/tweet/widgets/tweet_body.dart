import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../shared/design_system/text_styles.dart';
import '../../../../../shared/design_system/widgets/badges/user_close_badge_widget.dart';
import '../../../data/models/tweet_model.dart';
import '../../../domain/entities/tweet_badge_entity.dart';

class TweetBody extends StatelessWidget {
  const TweetBody({
    super.key,
    required String? content,
    required this.badges,
  }) : bodyContent = content;

  final String? bodyContent;
  final List<TweetBadgeEntity> badges;

  @override
  Widget build(BuildContext context) {
    final htmlBody = Html(
      data: bodyContent!,
      style: {
        'body': Style.fromTextStyle(kTextStyleFeedTweetBody),
        'iframe': Style(display: Display.none),
      },
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: setCloseUserPadding(badges)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildCloseUser(badges),
              ],
            ),
          ),
          htmlBody,
        ],
      ),
    );
  }

  double setCloseUserPadding(List<TweetBadgeEntity> badges) {
    return badges.any((badge) => badge.style == 'inline-block') ? 8.0 : 0.0;
  }

  Widget buildCloseUser(List<TweetBadgeEntity> badges) {
    final badge = badges.firstWhere(
      (b) => b.style == 'inline-block',
      orElse: () => TweetBadgeModel(
        code: '',
        description: '',
        imageUrl: '',
        name: '',
        popUp: 0,
        showDescription: 0,
        style: '',
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
}
