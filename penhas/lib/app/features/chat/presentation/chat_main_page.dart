import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

import 'chat_main_controller.dart';
import 'chat_main_talks_page.dart';

class ChatMainPage extends StatefulWidget {
  ChatMainPage({Key key}) : super(key: key);

  @override
  _ChatMainPageState createState() => _ChatMainPageState();
}

class _ChatMainPageState
    extends ModularState<ChatMainPage, ChatMainController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 55,
          backgroundColor: DesignSystemColors.systemBackgroundColor,
          bottom: chatTabBar,
        ),
        body: TabBarView(
          children: [
            ChatMainTalksPage(),
            Center(
              child: Text("Pessoas"),
            ),
          ],
        ),
      ),
    );
  }
}

extension _ChatMainPageStatePrivate on _ChatMainPageState {
  PreferredSizeWidget get chatTabBar => TabBar(
        indicatorColor: DesignSystemColors.pinky,
        labelColor: DesignSystemColors.pinky,
        labelStyle: kTextStyleChatTabSelected,
        unselectedLabelColor: DesignSystemColors.warnGrey,
        unselectedLabelStyle: kTextStyleChatTabUnselected,
        tabs: [
          Tab(text: "Conversas"),
          Tab(text: "Pessoas"),
        ],
      );
}
