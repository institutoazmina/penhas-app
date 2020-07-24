import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/core/states/mainboard_state.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_page.dart';
import 'package:penhas/app/features/feed/presentation/feed_module.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_module.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:penhas/app/shared/ui/penhas_drawer.dart';
import 'mainboard_controller.dart';

class MainboardPage extends StatefulWidget {
  final String title;
  const MainboardPage({Key key, this.title = "Mainboard"}) : super(key: key);

  @override
  _MainboardPageState createState() => _MainboardPageState();
}

class _MainboardPageState
    extends ModularState<MainboardPage, MainboardController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _helpCenterEnabled = false;
  String userName;
  Widget userAvatar;

  @override
  void initState() {
    super.initState();
    controller.userName.then((value) {
      setState(() {
        userName = value;
      });
    });
    controller.userAvatar
        .then((value) => SvgPicture.network(
              value,
              color: DesignSystemColors.darkIndigo,
              height: 36,
            ))
        .then((value) {
      setState(() {
        userAvatar = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBarBuilder(),
      drawer: PenhasDrawer(
          userName: userName,
          userAvatar: userAvatar,
          onLogout: () => controller.logoutPressed()),
      backgroundColor: Colors.white,
      body: _pagesBodyBuilder(),
      bottomNavigationBar: Observer(builder: (_) {
        return BottomAppBar(
          elevation: 20.0,
          color: _helpCenterEnabled
              ? DesignSystemColors.helpCenterButtonBar
              : Colors.white,
          child: Container(
            height: 56,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildFeedButton(),
                _buildComposeButton(),
                Container(width: 62),
                _buildChatButton(),
                _buildSupportButton(),
              ],
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildSupportButton() {
    return Expanded(
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => _changePage(MainboardState.supportPoint()),
        child: _buildBottomBarIcon(
          MainboardState.supportPoint(),
          controller.mainboardStore.selectedPage,
        ),
      ),
    );
  }

  Widget _buildChatButton() {
    return Expanded(
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => _changePage(MainboardState.chat()),
        child: _buildBottomBarIcon(
          MainboardState.chat(),
          controller.mainboardStore.selectedPage,
        ),
      ),
    );
  }

  Widget _buildComposeButton() {
    return Expanded(
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => _changePage(MainboardState.compose()),
        child: _buildBottomBarIcon(
          MainboardState.compose(),
          controller.mainboardStore.selectedPage,
        ),
      ),
    );
  }

  Widget _buildFeedButton() {
    return Expanded(
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => _changePage(MainboardState.feed()),
        child: _buildBottomBarIcon(
          MainboardState.feed(),
          controller.mainboardStore.selectedPage,
        ),
      ),
    );
  }

  void _changePage(MainboardState page) {
    setState(() {
      _helpCenterEnabled = page == MainboardState.helpCenter();
    });

    controller.mainboardStore.changePage(to: page);
  }

  Widget _buildBottomBarIcon(MainboardState current, MainboardState selected) {
    String asset;
    String rootPath = 'assets/images/svg/bottom_bar';

    asset = current.when(
      chat: () => '$rootPath/chat.svg',
      feed: () => '$rootPath/feed.svg',
      compose: () => '$rootPath/compose_tweet.svg',
      supportPoint: () => '$rootPath/support_point.svg',
      helpCenter: () => '$rootPath/emergency_controll.svg',
    );

    if (current == selected) {
      asset = current.when(
        chat: () => '$rootPath/chat_selected.svg',
        feed: () => '$rootPath/feed_selected.svg',
        compose: () => '$rootPath/compose_tweet_selected.svg',
        supportPoint: () => '$rootPath/support_point_selected.svg',
        helpCenter: () => '$rootPath/emergency_controll.svg',
      );
    }

    return SvgPicture.asset(
      asset,
      color: _helpCenterEnabled
          ? Colors.white
          : DesignSystemColors.buttonBarIconColor,
    );
  }

  AppBar _appBarBuilder() {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: _helpCenterEnabled
          ? DesignSystemColors.helpCenterNavigationBar
          : DesignSystemColors.ligthPurple,
      elevation: 0.0,
      centerTitle: false,
      title: _helpCenterEnabled
          ? Text(
              'Precisa de ajuda?',
              style: kTextStyleHelpCenterTitle,
            )
          : Icon(
              DesignSystemLogo.penhasLogo,
              color: Colors.white,
              size: 30,
            ),
      actions: <Widget>[
        _helpCenterEnabled
            ? Container()
            : IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () => {},
              )
      ],
    );
  }

  PageView _pagesBodyBuilder() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: controller.mainboardStore.pageController,
      children: <Widget>[
        FeedModule(),
        ComposeTweetPage(),
        Container(color: Colors.yellow),
        Container(color: Colors.green),
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
                  onPressed: () => _changePage(MainboardState.helpCenter()),
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
