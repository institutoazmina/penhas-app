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
      required this.controller,
      required this.chatMainPeopleController,
      required this.chatMainTalksController})
      : super(key: key);

  final ChatMainController controller;
  final ChatMainPeopleController chatMainPeopleController;
  final ChatMainTalksController chatMainTalksController;

  @override
  _ChatMainPageState createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage>
    with SingleTickerProviderStateMixin {
  ChatMainController get controller => widget.controller;
  ChatMainPeopleController get chatMainPeopleController =>
      widget.chatMainPeopleController;
  ChatMainTalksController get chatMainTalksController =>
      widget.chatMainTalksController;

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
            controller: chatMainTalksController,
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: chatTabBar(controller.tabItems),
                  ),
                ],
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
      isScrollable: true,
      labelColor: DesignSystemColors.white,
      indicatorColor: DesignSystemColors.white,
      labelStyle: chatTabSelectedTextStyle,
      unselectedLabelColor: DesignSystemColors.ligthPurple,
      unselectedLabelStyle: chatTabUnselectedTextStyle,
      padding: EdgeInsets.zero,
      indicator: BoxDecoration(
          color: DesignSystemColors.ligthPurple,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: DesignSystemColors.ligthPurple, width: 1)),
      indicatorPadding: const EdgeInsets.only(right: 16.0),
      labelPadding: const EdgeInsets.only(right: 16.0),
      tabs: items
          .map((e) => _CustomTabWidget(
                title: e.title!,
              ))
          .toList(),
    );
  }

  Widget buildBody(List<ChatTabItem> items) {
    final widgets = items.map(
      (e) => e == ChatTabItem.people
          ? ChatMainPeoplePage(
              controller: chatMainPeopleController,
            )
          : ChatMainTalksPage(
              controller: chatMainTalksController,
            ),
    );
    return TabBarView(children: widgets.toList());
  }
}

class _CustomTabWidget extends StatelessWidget {
  const _CustomTabWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border:
                Border.all(color: DesignSystemColors.ligthPurple, width: 1)),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
          child: Text(title),
        ));
  }
}

extension _ChatMainPageStateTextStyle on _ChatMainPageState {
  TextStyle get chatTabSelectedTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get chatTabUnselectedTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.bluishPurple,
        fontWeight: FontWeight.normal,
      );
}
