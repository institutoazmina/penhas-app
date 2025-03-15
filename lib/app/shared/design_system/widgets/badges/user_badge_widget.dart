import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../colors.dart';
import '../../text_styles.dart';

class UserBadgeWidget extends StatelessWidget {
  const UserBadgeWidget({
    super.key,
    required this.badgePopUp,
    required this.badgeImageUrl,
    this.badgeImageUrlBlack,
    required this.badgeDescription,
    required this.badgeName,
    required this.badgeShowDescription,
    required this.isLightBackground,
  });

  final int badgePopUp;
  final String badgeImageUrl;
  final String? badgeImageUrlBlack;
  final int badgeShowDescription;
  final String badgeDescription;
  final String badgeName;
  final bool isLightBackground;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => badgePopUp == 1
          ? await showModalBottomSheet(
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
            )
          : null,
      child: badgeImageUrl.isNotEmpty
          ? SvgPicture.network(
              returnCorrectImage(
                  badgeImageUrl, badgeImageUrlBlack, isLightBackground),
              height: 16,
              width: 16,
              colorFilter: ColorFilter.mode(
                  returnCorrectColor(isLightBackground), BlendMode.color),
            )
          : const SizedBox.shrink(),
    );
  }

  String returnCorrectImage(String badgeImageUrl, String? badgeImageUrlBlack,
      bool isLightBackground) {
    if (isLightBackground) {
      return badgeImageUrlBlack ?? badgeImageUrl;
    } else {
      return badgeImageUrl;
    }
  }

  Color returnCorrectColor(bool isLightBackground) {
    if (isLightBackground) {
      return DesignSystemColors.bluishPurple;
    } else {
      return DesignSystemColors.white;
    }
  }
}

class _DescriptionBottomSheetWidget extends StatelessWidget {
  const _DescriptionBottomSheetWidget({
    required this.badgeShowDescription,
    required this.badgeDescription,
    required this.badgeName,
  });
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
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                        Modular.to.pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 32,
                        color: DesignSystemColors.darkIndigoThree,
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
