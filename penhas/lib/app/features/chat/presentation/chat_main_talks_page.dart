import 'package:flutter/material.dart';
import 'package:penhas/app/features/chat/presentation/pages/chat_talk_card.dart';

class ChatMainTalksPage extends StatelessWidget {
  const ChatMainTalksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          ),
        ],
      ),
    );
  }
}
