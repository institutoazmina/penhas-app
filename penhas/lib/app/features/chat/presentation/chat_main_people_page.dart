import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'pages/chat_people_filter_card.dart';
import 'pages/chat_talk_card.dart';

class ChatMainPeoplePage extends StatelessWidget {
  const ChatMainPeoplePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> dataSource = [
      ChatPeopleFilterCard(),
      ChatTalkCard(),
      ChatTalkCard(),
      ChatTalkCard()
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      color: DesignSystemColors.systemBackgroundColor,
      child: ListView.builder(
        itemCount: dataSource.length,
        itemBuilder: (context, index) {
          return dataSource[index];
        },
      ),
    );
  }
}
