import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_tab_item.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_controller.dart';
import 'package:penhas/app/features/chat/presentation/people/chat_main_people_page.dart';
import 'package:penhas/app/features/chat/presentation/talk/chat_main_talks_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatMainPage extends StatefulWidget {
  ChatMainPage({Key? key}) : super(key: key);

  @override
  _ChatMainPageState createState() => _ChatMainPageState();
}

class _ChatMainPageState
    extends ModularState<ChatMainPage, ChatMainController> {
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
    return const SafeArea(
      child: SizedBox.expand(
        child: Scaffold(
          body: ChatMainTalksPage(),
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
      tabs: items.map((e) => Tab(text: e.title!)).toList(),
    );
  }

  Widget buildBody(List<ChatTabItem> items) {
    final widgets = items.map(
      (e) => e == ChatTabItem.people
          ? const ChatMainPeoplePage()
          : const ChatMainTalksPage(),
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
