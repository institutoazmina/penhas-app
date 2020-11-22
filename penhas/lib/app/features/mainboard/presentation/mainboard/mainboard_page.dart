import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_security_state.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/chat/presentation/chat_main_module.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_page.dart';
import 'package:penhas/app/features/feed/presentation/feed_module.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_module.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_page.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/pages/mainboard_button_page.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/pages/mainboard_notification_page.dart';
import 'package:penhas/app/features/support_center/presentation/support_center_module.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'mainboard_controller.dart';
import 'pages/mainboard_app_bar_page.dart';
import 'pages/mainboard_bottom_navigation_page.dart';

class MainboardPage extends StatefulWidget {
  final String title;
  const MainboardPage({Key key, this.title = "Mainboard"}) : super(key: key);

  @override
  _MainboardPageState createState() => _MainboardPageState();
}

class _MainboardPageState
    extends ModularState<MainboardPage, MainboardController>
    with WidgetsBindingObserver {
  String userName;
  Widget userAvatar;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    controller.changeAppState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return controller.securityState.when(
        enable: () =>
            enabledSecurityMode(controller.mainboardStore.selectedPage),
        disable: () =>
            disabledSecurityMode(controller.mainboardStore.selectedPage),
      );
    });
  }

  PageView _pagesBodyBuilder() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: controller.mainboardStore.pageController,
      children: <Widget>[
        FeedModule(),
        ComposeTweetPage(),
        ChatMainModule(),
        SupportCenterModule(),
        HelpCenterModule(),
      ],
    );
  }

  Widget _buildFab() {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return keyboardIsOpened
        ? Container()
        : Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Container(
              width: 60.0,
              height: 60.0,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: DesignSystemColors.ligthPurple,
                  onPressed: () => controller.mainboardStore
                      .changePage(to: MainboardState.helpCenter()),
                  child: SvgPicture.asset(
                    'assets/images/svg/bottom_bar/emergency_controll.svg',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
}

extension _SecurityModeBuilder on _MainboardPageState {
  Widget enabledSecurityMode(MainboardState currentPage) {
    return Scaffold(
      appBar: MainBoardAppBarPage(
        currentPage: controller.mainboardStore.selectedPage,
        counter: controller.notificationCounter,
      ),
      drawer: PenhasDrawerPage(),
      backgroundColor: Colors.white,
      body: _pagesBodyBuilder(),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MainboardBottomNavigationPage(
        securityState: MainboardSecurityState.enable(),
        currentPage: controller.mainboardStore.selectedPage,
        pages: controller.mainboardStore.pages,
        onSelect: (v) => controller.mainboardStore.changePage(to: v),
      ),
    );
  }

  Widget disabledSecurityMode(MainboardState currentPage) {
    return Scaffold(
      appBar: MainBoardAppBarPage(
        currentPage: controller.mainboardStore.selectedPage,
        counter: controller.notificationCounter,
      ),
      drawer: PenhasDrawerPage(),
      backgroundColor: Colors.white,
      body: _pagesBodyBuilder(),
      bottomNavigationBar: MainboardBottomNavigationPage(
        securityState: MainboardSecurityState.disable(),
        currentPage: controller.mainboardStore.selectedPage,
        pages: controller.mainboardStore.pages,
        onSelect: (v) => controller.mainboardStore.changePage(to: v),
      ),
    );
  }
}

extension _BottomNavigationBuilder on _MainboardPageState {
  // BottomAppBar bottomNavigationBuilder(MainboardState currentPage) {
  //   final bottomColor = currentPage.maybeWhen(
  //     helpCenter: () => DesignSystemColors.helpCenterButtonBar,
  //     orElse: () => DesignSystemColors.white,
  //   );

  //   return BottomAppBar(
  //     elevation: 20.0,
  //     color: bottomColor,
  //     child: Container(
  //       height: 56,
  //       child: Row(
  //         mainAxisSize: MainAxisSize.max,
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           _buildFeedButton(),
  //           _buildComposeButton(),
  //           Container(width: 62),
  //           _buildChatButton(),
  //           _buildSupportButton(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildSupportButton() {
  //   return MainboarButtonPage(
  //     currentPage: MainboardState.supportPoint(),
  //     pageSelected: controller.mainboardStore.selectedPage,
  //     onSeletec:  // onSeletec: controller.mainboardStore.selectedPage
  //   );
  // }

  // Widget _buildChatButton() {
  //   return MainboarButtonPage(
  //     currentPage: MainboardState.chat(),
  //     pageSelected: controller.mainboardStore.selectedPage,
  //     onSeletec: (v) => controller.mainboardStore.changePage(
  //         to: v), // onSeletec: controller.mainboardStore.selectedPage
  //   );
  // }

  // Widget _buildComposeButton() {
  //   return MainboarButtonPage(
  //     currentPage: MainboardState.compose(),
  //     pageSelected: controller.mainboardStore.selectedPage,
  //     onSeletec: (v) => controller.mainboardStore.changePage(
  //         to: v), // onSeletec: controller.mainboardStore.selectedPage
  //   );
  // }

  // Widget _buildFeedButton() {
  //   return MainboarButtonPage(
  //     currentPage: MainboardState.feed(),
  //     pageSelected: controller.mainboardStore.selectedPage,
  //     onSeletec: (v) => controller.mainboardStore.changePage(
  //         to: v), // onSeletec: controller.mainboardStore.selectedPage
  //   );
  // }
}
