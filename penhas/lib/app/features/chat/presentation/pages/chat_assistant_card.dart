import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatAssistantCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;

  const ChatAssistantCard({
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
      decoration: BoxDecoration(
        color: DesignSystemColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 8.0,
          )
        ],
      ),
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

extension _ChatTalkCardPrivate on ChatAssistantCard {
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
