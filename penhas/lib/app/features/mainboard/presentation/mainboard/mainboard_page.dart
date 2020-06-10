import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/core/states/mainboard_state.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_page.dart';
import 'package:penhas/app/features/feed/presentation/feed_module.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ComposeTweetPage newTweetPage = ComposeTweetPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: PenhasDrawer(onLogout: () => controller.logoutPressed()),
      backgroundColor: Colors.white,
      body: _buildBody(),
      bottomNavigationBar: Observer(builder: (_) {
        return BottomAppBar(
          elevation: 20.0,
          child: Container(
            height: 56,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  padding: EdgeInsets.only(right: 6.0),
                  onPressed: () => controller.mainboardStore.changePage(
                    to: MainboardState.feed(),
                  ),
                  child: _buildBottomBarIcon(
                    MainboardState.feed(),
                    controller.mainboardStore.selectedPage,
                  ),
                ),
                FlatButton(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  padding: EdgeInsets.only(right: 32.0),
                  onPressed: () => controller.mainboardStore.changePage(
                    to: MainboardState.compose(),
                  ),
                  child: _buildBottomBarIcon(
                    MainboardState.compose(),
                    controller.mainboardStore.selectedPage,
                  ),
                ),
                FlatButton(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  padding: EdgeInsets.only(left: 32.0),
                  onPressed: () => controller.mainboardStore.changePage(
                    to: MainboardState.chat(),
                  ),
                  child: _buildBottomBarIcon(
                    MainboardState.chat(),
                    controller.mainboardStore.selectedPage,
                  ),
                ),
                FlatButton(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  padding: EdgeInsets.only(left: 6.0),
                  onPressed: () => controller.mainboardStore.changePage(
                    to: MainboardState.supportPoint(),
                  ),
                  child: _buildBottomBarIcon(
                    MainboardState.supportPoint(),
                    controller.mainboardStore.selectedPage,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBottomBarIcon(MainboardState current, MainboardState selected) {
    String asset;
    String rootPath = 'assets/images/svg/bottom_bar';

    asset = current.when(
      chat: () => '$rootPath/chat.svg',
      feed: () => '$rootPath/feed.svg',
      compose: () => '$rootPath/compose_tweet.svg',
      supportPoint: () => '$rootPath/support_point.svg',
    );

    if (current == selected) {
      asset = current.when(
        chat: () => '$rootPath/chat_selected.svg',
        feed: () => '$rootPath/feed_selected.svg',
        compose: () => '$rootPath/compose_tweet_selected.svg',
        supportPoint: () => '$rootPath/support_point_selected.svg',
      );
    }

    return SvgPicture.asset(asset);
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: DesignSystemColors.ligthPurple,
      elevation: 0.0,
      centerTitle: false,
      title: Icon(
        DesignSystemLogo.penhasLogo,
        color: Colors.white,
        size: 30,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications_none),
          onPressed: () => {},
        )
      ],
    );
  }

  PageView _buildBody() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: controller.mainboardStore.pageController,
      children: <Widget>[
        FeedModule(),
        newTweetPage,
        Container(color: Colors.yellow),
        Container(color: Colors.green),
      ],
    );
  }

  Container _buildFab() {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return keyboardIsOpened
        ? Container()
        : Container(
            width: 60.0,
            height: 60.0,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: DesignSystemColors.ligthPurple,
                onPressed: () {},
                child: SvgPicture.asset(
                  'assets/images/svg/bottom_bar/emergency_controll.svg',
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}
