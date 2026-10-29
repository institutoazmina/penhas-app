import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../shared/design_system/text_styles.dart';
import '../../../../../shared/design_system/widgets/badges/user_close_badge_widget.dart';
import '../../../../../shared/navigation/app_navigator.dart';
import '../../../../../shared/utils/html_link.dart';
import '../../../data/models/tweet_model.dart';
import '../../../domain/entities/tweet_badge_entity.dart';
import '../../../domain/entities/tweet_media_entity.dart';
import 'tweet_media.dart';

class TweetBody extends StatelessWidget {
  const TweetBody({
    super.key,
    required String? content,
    required this.badges,
    this.media = const [],
    this.highQualityMedia = false,
    this.apiToken,
    this.trustedServer,
  }) : bodyContent = content;

  final String? bodyContent;
  final List<TweetBadgeEntity> badges;
  final List<TweetMediaEntity> media;
  final bool highQualityMedia;
  final Future<String>? apiToken;
  final Uri? trustedServer;

  @override
  Widget build(BuildContext context) {
    final content = bodyContent ?? '';

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
          if (content.trim().isNotEmpty)
            Html(
              data: content,
              style: {
                'body': Style.fromTextStyle(kTextStyleFeedTweetBody),
                'iframe': Style(display: Display.none),
              },
              onLinkTap: (url, attributes, element) {
                final sanitizedUrl = sanitizeHtmlUrl(url);
                if (sanitizedUrl != null) {
                  AppNavigator.launchURL(sanitizedUrl);
                }
              },
            ),
          if (media.isNotEmpty)
            TweetMedia(
              media: media,
              highQuality: highQualityMedia,
              apiToken: apiToken,
              trustedServer: trustedServer,
            ),
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
