import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../main_menu/presentation/penhas_drawer_page.dart';
import 'mainboard_controller.dart';
import 'pages/mainboard_app_bar_page.dart';
import 'pages/mainboard_body_page.dart';
import 'pages/mainboard_bottom_navigation_page.dart';

class MainboardPage extends StatefulWidget {
  const MainboardPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final MainboardController controller;

  static final mainBoardKey = GlobalKey<ScaffoldState>(
    debugLabel: 'main-board-scaffold-key',
  );

  static MainboardPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<MainboardPageState>();

  @override
  MainboardPageState createState() => MainboardPageState();
}

class MainboardPageState extends State<MainboardPage>
    with WidgetsBindingObserver {
  MainboardController get controller => widget.controller;

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
    return Observer(
      builder: (context) => Scaffold(
        appBar: MainBoardAppBarPage(
          counter: controller.notificationCounter,
          resetCounter: controller.resetNotificatinCounter,
          currentPage: controller.mainboardStore.selectedPage,
        ),
        drawer: const PenhasDrawerPage(),
        backgroundColor: Colors.white,
        body: Scaffold(
          key: MainboardPage.mainBoardKey,
          body: MainboardBodyPage(
            pages: controller.mainboardStore.pages,
            pageController: controller.mainboardStore.pageController,
          ),
        ),
        bottomNavigationBar: MainboardBottomNavigationPage(
          currentPage: controller.mainboardStore.selectedPage,
          pages: controller.mainboardStore.pages,
          onSelect: controller.mainboardStore.switchToPage,
        ),
      ),
    );
  }
}
