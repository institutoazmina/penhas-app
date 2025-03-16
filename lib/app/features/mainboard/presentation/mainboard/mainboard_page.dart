import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../feed/presentation/compose_tweet/compose_tweet_controller.dart';
import '../../../main_menu/presentation/penhas_drawer_controller.dart';
import '../../../main_menu/presentation/penhas_drawer_page.dart';
import '../../../quiz/presentation/tutorial/stealth_mode_tutorial_page_controller.dart';
import '../../domain/states/mainboard_state.dart';
import 'mainboard_controller.dart';
import 'pages/mainboard_app_bar_page.dart';
import 'pages/mainboard_body_page.dart';
import 'pages/mainboard_bottom_navigation_page.dart';

class MainboardPage extends StatefulWidget {
  const MainboardPage({
    super.key,
    required this.controller,
    required this.composeTweetController,
    required this.penhasDrawerController,
    required this.stealthController,
  });

  final MainboardController controller;
  final ComposeTweetController composeTweetController;
  final PenhasDrawerController penhasDrawerController;
  final StealthModeTutorialPageController stealthController;

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
  PenhasDrawerController get _penhasDrawerController =>
      widget.penhasDrawerController;
  ComposeTweetController get composeTweetController =>
      widget.composeTweetController;
  StealthModeTutorialPageController get _stealthController =>
      widget.stealthController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize();
    });
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
          resetCounter: controller.resetNotificationCounter,
          currentPage: controller.mainboardStore.selectedPage,
        ),
        drawer: PenhasDrawerPage(
          controller: _penhasDrawerController,
          stealthController: _stealthController,
        ),
        backgroundColor: Colors.white,
        body: Scaffold(
          key: MainboardPage.mainBoardKey,
          body: MainboardBodyPage(
            pages: controller.mainboardStore.pages,
            pageController: controller.mainboardStore.pageController,
            composeTweetController: composeTweetController,
          ),
        ),
        bottomNavigationBar: MainboardBottomNavigationPage(
          currentPage: controller.mainboardStore.selectedPage,
          pages: controller.mainboardStore.pages,
          onSelect: controller.mainboardStore.switchToPage,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: DesignSystemColors.ligthPurple,
          onPressed: () => controller.mainboardStore
              .switchToPage(const MainboardState.helpCenter()),
          child: SvgPicture.asset(
            'assets/images/svg/bottom_bar/emergency_controll.svg',
            colorFilter: const ColorFilter.mode(
                DesignSystemColors.white, BlendMode.srcIn),
            semanticsLabel: 'Socorro',
          ),
        ),
      ),
    );
  }
}
