import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatTalkCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;

  const ChatTalkCard({
    Key key,
    this.title,
    this.description,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: 155,
      color: DesignSystemColors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                title,
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              description,
              style: descriptionStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

extension _ChatTalkCardPrivate on ChatTalkCard {
  TextStyle get titleStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.45,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.bold);
  TextStyle get descriptionStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 14.0,
      height: 1.3,
      letterSpacing: 0.45,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.normal);
}
