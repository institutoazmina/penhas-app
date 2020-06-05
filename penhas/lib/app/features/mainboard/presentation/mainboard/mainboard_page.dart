import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  tooltip: 'Feed',
                  icon: _buildBottomBarIcon(0, controller.selectedIndex),
                  onPressed: () => controller.changePage(0),
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: _buildBottomBarIcon(1, controller.selectedIndex),
                  onPressed: () => controller.changePage(1),
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: _buildBottomBarIcon(2, controller.selectedIndex),
                  onPressed: () => controller.changePage(2),
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: _buildBottomBarIcon(3, controller.selectedIndex),
                  onPressed: () => controller.changePage(3),
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                )
              ],
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBottomBarIcon(int index, int selected) {
    String asset;
    if (index == 0) {
      asset = 'assets/images/svg/bottom_bar/feed.svg';
    } else if (index == 1) {
      asset = 'assets/images/svg/bottom_bar/compose_tweet.svg';
    } else if (index == 2) {
      asset = 'assets/images/svg/bottom_bar/chat.svg';
    } else if (index == 3) {
      asset = 'assets/images/svg/bottom_bar/support_point.svg';
    }

    if (index == selected) {
      if (selected == 0) {
        asset = 'assets/images/svg/bottom_bar/feed_selected.svg';
      } else if (selected == 1) {
        asset = 'assets/images/svg/bottom_bar/compose_tweet_selected.svg';
      } else if (selected == 2) {
        asset = 'assets/images/svg/bottom_bar/chat_selected.svg';
      } else if (selected == 3) {
        asset = 'assets/images/svg/bottom_bar/support_point_selected.svg';
      }
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
      controller: controller.pageController,
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
