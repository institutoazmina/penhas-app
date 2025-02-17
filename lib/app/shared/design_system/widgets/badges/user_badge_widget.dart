import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../features/feed/domain/entities/tweet_badge_entity.dart';
import '../../colors.dart';
import '../../text_styles.dart';

class UserBadgeWidget extends StatelessWidget {
  const UserBadgeWidget({Key? key, required this.badge}) : super(key: key);

  final TweetBadgeEntity badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => badge.popUp == 1
          ? showModalBottomSheet(
              context: context,
              barrierColor: Colors.transparent,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _DescriptionBottomSheetWidget(
                    badge: badge,
                  ),
                );
              },
            )
          : null,
      child: Image.network(
        badge.imageUrl,
        height: 16,
        width: 16,
      ),
    );
  }
}

class _DescriptionBottomSheetWidget extends StatelessWidget {
  const _DescriptionBottomSheetWidget({
    Key? key,
    required this.badge,
  }) : super(key: key);

  final TweetBadgeEntity badge;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: DesignSystemColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: DesignSystemColors.ligthPurple2,
            borderRadius: BorderRadius.circular(8.0)),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    badge.name,
                    style: kTextStyleFeedTweetTitle,
                  )),
                  IconButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 32,
                      )),
                ],
              ),
              badge.showDescription == 1
                  ? Text(
                      badge.description,
                      style: kTextStyleGuardianBodyTextStyle,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
