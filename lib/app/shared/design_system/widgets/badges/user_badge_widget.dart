import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../colors.dart';
import '../../text_styles.dart';

class UserBadgeWidget extends StatelessWidget {
  const UserBadgeWidget({
    Key? key,
    required this.badgePopUp,
    required this.badgeImageUrl,
    required this.badgeDescription,
    required this.badgeName,
    required this.badgeShowDescription,
  }) : super(key: key);

  final int badgePopUp;
  final String badgeImageUrl;
  final int badgeShowDescription;
  final String badgeDescription;
  final String badgeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => badgePopUp == 1
          ? showChatAction(
              context, badgeShowDescription, badgeDescription, badgeName)
          : null,
      child: badgeImageUrl.isNotEmpty
          ? Image.network(
              badgeImageUrl,
              height: 16,
              width: 16,
            )
          : const SizedBox.shrink(),
    );
  }
}

Future<void> showChatAction(
  BuildContext context,
  int badgeShowDescription,
  String badgeDescription,
  String badgeName,
) async {
  await showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _DescriptionBottomSheetWidget(
          badgeDescription: badgeDescription,
          badgeName: badgeName,
          badgeShowDescription: badgeShowDescription,
        ),
      );
    },
  );
}

class _DescriptionBottomSheetWidget extends StatelessWidget {
  const _DescriptionBottomSheetWidget({
    Key? key,
    required this.badgeShowDescription,
    required this.badgeDescription,
    required this.badgeName,
  }) : super(key: key);
  final int badgeShowDescription;
  final String badgeDescription;
  final String badgeName;

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
                    badgeName,
                    style: kTextStyleFeedTweetTitle,
                  )),
                  IconButton(
                      onPressed: () {
                        _closeBottomSheet();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 32,
                      )),
                ],
              ),
              badgeShowDescription == 1
                  ? Text(
                      badgeDescription,
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

void _closeBottomSheet() {
  Modular.to.pop();
}
