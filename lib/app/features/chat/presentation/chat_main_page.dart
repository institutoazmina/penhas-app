import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../shared/design_system/colors.dart';
import '../domain/entities/chat_tab_item.dart';
import 'chat_main_controller.dart';
import 'people/chat_main_people_controller.dart';
import 'people/chat_main_people_page.dart';
import 'talk/chat_main_talks_controller.dart';
import 'talk/chat_main_talks_page.dart';

class ChatMainPage extends StatefulWidget {
  const ChatMainPage(
      {Key? key,
      required this.chatMainPeopleController,
      required this.controller,
      required this.iChatMainTalksController})
      : super(key: key);

  final ChatMainPeopleController chatMainPeopleController;
  final ChatMainController controller;
  final IChatMainTalksController iChatMainTalksController;

  @override
  _ChatMainPageState createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  ChatMainController get controller => widget.controller;
  ChatMainPeopleController get chatMainPeopleController =>
      widget.chatMainPeopleController;
  IChatMainTalksController get iChatMainTalksController =>
      widget.iChatMainTalksController;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return controller.securityState.when(
          onlySupport: () => buildSupportChat(),
          supportAndPrivate: () => buildSupportAndPrivateChat(),
        );
      },
    );
  }
}

extension _ChatMainBuilder on _ChatMainPageState {
  Widget buildSupportChat() {
    return SafeArea(
      child: SizedBox.expand(
        child: Scaffold(
          body: ChatMainTalksPage(
            controller: iChatMainTalksController,
          ),
        ),
      ),
    );
  }

  Widget buildSupportAndPrivateChat() {
    return SafeArea(
      child: SizedBox.expand(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                color: DesignSystemColors.systemBackgroundColor,
                child: chatTabBar(controller.tabItems),
              ),
              Expanded(child: buildBody(controller.tabItems)),
            ],
          ),
        ),
      ),
    );
  }
}

extension _ChatMainPageStatePrivate on _ChatMainPageState {
  PreferredSizeWidget chatTabBar(List<ChatTabItem> items) {
    return TabBar(
      labelColor: DesignSystemColors.pinky,
      labelStyle: chatTabSelectedTextStyle,
      indicatorColor: DesignSystemColors.pinky,
      unselectedLabelColor: DesignSystemColors.warnGrey,
      unselectedLabelStyle: chatTabUnselectedTextStyle,
      tabs: items.map((e) => Tab(text: e.title)).toList(),
    );
  }

  Widget buildBody(List<ChatTabItem> items) {
    final widgets = items.map(
      (e) => e == ChatTabItem.people
          ? ChatMainPeoplePage(
              controller: chatMainPeopleController,
            )
          : ChatMainTalksPage(
              controller: iChatMainTalksController,
            ),
    );
    return TabBarView(children: widgets.toList());
  }
}

extension _ChatMainPageStateTextStyle on _ChatMainPageState {
  TextStyle get chatTabSelectedTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.pinky,
        fontWeight: FontWeight.bold,
      );

  TextStyle get chatTabUnselectedTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.pinky,
        fontWeight: FontWeight.normal,
      );
}
