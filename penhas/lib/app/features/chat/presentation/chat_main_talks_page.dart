import 'package:flutter/material.dart';
import 'package:penhas/app/features/chat/presentation/pages/chat_talk_card.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatMainTalksPage extends StatelessWidget {
  const ChatMainTalksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.greenAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChatTalkCard(
                title: "Assistente PenhaS",
                description: "Entenda se você está em situação de violência",
                icon: Image.asset(
                  "assets/images/chat/penhasAssistant/penhasAssistant.png",
                  width: 40,
                  height: 40,
                ),
              ),
              ChatTalkCard(
                title: "Contato PenhaS",
                description: "Fale com as adminstradoras do app",
                icon: Image.asset(
                  "assets/images/chat/penhasContact/penhasContact.png",
                  width: 40,
                  height: 40,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Suas conversas (4)",
              style: talksDividerTitleTextStyle,
            ),
          )
        ],
      ),
    );
  }
}

extension _ChatMainTalksPageTextStyle on ChatMainTalksPage {
  TextStyle get talksDividerTitleTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 16.0,
      letterSpacing: 0.5,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.bold);
}
