import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_tab_item.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

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
          child: Observer(builder: (_) {
            return Scaffold(
              appBar: buildAppBar(controller.tabItems),
              body: buildBody(controller.tabItems),
            );
          }),
        ),
      ),
    );
  }
}

extension _ChatMainPageStatePrivate on _ChatMainPageState {
  PreferredSizeWidget buildAppBar(List<ChatTabItem> items) {
    if (items.length > 1) {
      return AppBar(
        elevation: 0,
        toolbarHeight: 55,
        backgroundColor: DesignSystemColors.systemBackgroundColor,
        bottom: chatTabBar(items),
      );
    }

    return null;
  }

  PreferredSizeWidget chatTabBar(List<ChatTabItem> items) {
    return TabBar(
      labelColor: DesignSystemColors.pinky,
      labelStyle: chatTabSelectedTextStyle,
      indicatorColor: DesignSystemColors.pinky,
      unselectedLabelColor: DesignSystemColors.warnGrey,
      unselectedLabelStyle: chatTabUnselectedTextStyle,
      tabs: items.map((e) => Tab(text: e.headerName)).toList(),
    );
  }

  Widget buildBody(List<ChatTabItem> items) {
    if (items.length > 1) {
      return TabBarView(children: [
        ChatMainTalksPage(),
        ChatMainPeoplePage(),
      ]);
    }

    return ChatMainTalksPage();
  }
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
