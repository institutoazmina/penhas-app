import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/chat/presentation/pages/chat_assistant_card.dart';
import 'package:penhas/app/features/chat/presentation/pages/chat_talk_card.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'chat_main_talks_controller.dart';

class ChatMainTalksPage extends StatefulWidget {
  const ChatMainTalksPage({Key key}) : super(key: key);

  @override
  _ChatMainTalksPageState createState() => _ChatMainTalksPageState();
}

class _ChatMainTalksPageState
    extends ModularState<ChatMainTalksPage, ChatMainTalksController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      color: DesignSystemColors.systemBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChatAssistantCard(
                  title: "Assistente PenhaS",
                  description: "Entenda se você está em situação de violência",
                  icon: Image.asset(
                    "assets/images/chat/penhasAssistant/penhasAssistant.png",
                    width: 40,
                    height: 40,
                  ),
                ),
                ChatAssistantCard(
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Text(
              "Suas conversas (4)",
              style: talksDividerTitleTextStyle,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => print("Ola mundo!"),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return talkCard(index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget talkCard(int index) {
    return ChatTalkCard();
  }
}

extension _ChatMainTalksPageTextStyle on _ChatMainTalksPageState {
  TextStyle get talksDividerTitleTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 16.0,
      letterSpacing: 0.5,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.bold);
}
