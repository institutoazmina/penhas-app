import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatTalkCard extends StatelessWidget {
  const ChatTalkCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[350]),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color.fromRGBO(239, 239, 239, 1.0),
              radius: 20,
              child:
                  SvgPicture.asset("assets/images/svg/drawer/user_profile.svg"),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 16),
                    Text("Quincy Renata", style: cardTitleTextStyle),
                    Text("Online", style: cardStatusTextStyle),
                  ],
                ),
              ),
            ),
            Text("25/03/2020", style: cardStatusTextStyle),
          ],
        ),
      ),
    );
  }
}

extension _ChatTalkCardPrivate on ChatTalkCard {
  TextStyle get cardTitleTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.5,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.bold);
  TextStyle get cardStatusTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 12.0,
      letterSpacing: 0.4,
      color: DesignSystemColors.warnGrey,
      fontWeight: FontWeight.normal);
}
