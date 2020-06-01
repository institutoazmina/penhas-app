import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/feed/presenter/feed_module.dart';
import 'package:penhas/app/features/feed/presenter/new_toot/new_toot/new_toot_page.dart';
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
  final NewTootPage newTootPage = NewTootPage();

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
                  icon:
                      SvgPicture.asset('assets/images/svg/bottom_bar/feed.svg'),
                  onPressed: () => controller.changePage(0),
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: SvgPicture.asset(
                      'assets/images/svg/bottom_bar/new_toot.svg'),
                  onPressed: () => controller.changePage(1),
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(left: 28.0),
                  icon:
                      SvgPicture.asset('assets/images/svg/bottom_bar/chat.svg'),
                  onPressed: () => controller.changePage(2),
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: SvgPicture.asset(
                      'assets/images/svg/bottom_bar/support_point.svg'),
                  onPressed: () => controller.changePage(3),
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
        newTootPage,
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
