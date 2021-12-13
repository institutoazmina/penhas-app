import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_page.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_controller.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/pages/mainboard_app_bar_page.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/pages/mainboard_body_page.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/pages/mainboard_bottom_navigation_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class MainboardPage extends StatefulWidget {
  const MainboardPage({Key? key, this.title = 'Mainboard'}) : super(key: key);

  final String title;
  const MainboardPage({Key? key, this.title = "Mainboard"}) : super(key: key);

  @override
  _MainboardPageState createState() => _MainboardPageState();
}

class _MainboardPageState
    extends ModularState<MainboardPage, MainboardController>
    with WidgetsBindingObserver {
  String? userName;
  Widget? userAvatar;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
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
        enable: () => enabledSecurityMode(),
        disable: () => disabledSecurityMode(),
      );
    });
  }

  Widget _buildFab() {
    final bool keyboardIsOpened =
        MediaQuery.of(context).viewInsets.bottom != 0.0;

    return keyboardIsOpened
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
              width: 60.0,
              height: 60.0,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: DesignSystemColors.ligthPurple,
                  onPressed: () => controller.mainboardStore
                      .changePage(to: const MainboardState.helpCenter()),
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
  Widget enabledSecurityMode() {
    return Scaffold(
      appBar: MainBoardAppBarPage(
        counter: controller.notificationCounter,
        resetCounter: controller.resetNotificatinCounter,
        currentPage: controller.mainboardStore.selectedPage,
      ),
      drawer: const PenhasDrawerPage(),
      backgroundColor: Colors.white,
      body: MainboardBodyPage(
        pages: controller.mainboardStore.pages,
        pageController: controller.mainboardStore.pageController,
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MainboardBottomNavigationPage(
        currentPage: controller.mainboardStore.selectedPage,
        pages: controller.mainboardStore.pages,
        onSelect: (v) => controller.mainboardStore.changePage(to: v),
      ),
    );
  }

  Widget disabledSecurityMode() {
    return Scaffold(
      appBar: MainBoardAppBarPage(
        counter: controller.notificationCounter,
        resetCounter: controller.resetNotificatinCounter,
        currentPage: controller.mainboardStore.selectedPage,
      ),
      drawer: const PenhasDrawerPage(),
      backgroundColor: Colors.white,
      body: MainboardBodyPage(
        pages: controller.mainboardStore.pages,
        pageController: controller.mainboardStore.pageController,
      ),
      bottomNavigationBar: MainboardBottomNavigationPage(
        currentPage: controller.mainboardStore.selectedPage,
        pages: controller.mainboardStore.pages,
        onSelect: (v) => controller.mainboardStore.changePage(to: v),
      ),
    );
  }
}
