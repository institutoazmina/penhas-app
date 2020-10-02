import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'chat_main_controller.dart';

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
          backgroundColor: DesignSystemColors.systemBackgroundColor,
          bottom: TabBar(tabs: [Tab(text: "Conversas"), Tab(text: "Pessoas")]),
        ),
        body: TabBarView(children: [
          Center(
            child: Text("Conversar"),
          ),
          Center(
            child: Text("Pessoas"),
          ),
        ]),
      ),
    );
  }
}
