import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

import 'chat_main_controller.dart';
import 'chat_main_people_page.dart';
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
    return SafeArea(
      child: SizedBox.expand(
        child: DefaultTabController(
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
                ChatMainPeoplePage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension _ChatMainPageStatePrivate on _ChatMainPageState {
  PreferredSizeWidget get chatTabBar => TabBar(
        indicatorColor: DesignSystemColors.pinky,
        labelColor: DesignSystemColors.pinky,
        labelStyle: chatTabSelectedTextStyle,
        unselectedLabelColor: DesignSystemColors.warnGrey,
        unselectedLabelStyle: chatTabUnselectedTextStyle,
        tabs: [
          Tab(text: "Conversas"),
          Tab(text: "Pessoas"),
        ],
      );
}

extension _ChatMainPageStateTextStyle on _ChatMainPageState {
  TextStyle get chatTabSelectedTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.4,
      color: DesignSystemColors.pinky,
      fontWeight: FontWeight.bold);

  TextStyle get chatTabUnselectedTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.4,
      color: DesignSystemColors.pinky,
      fontWeight: FontWeight.normal);
}
