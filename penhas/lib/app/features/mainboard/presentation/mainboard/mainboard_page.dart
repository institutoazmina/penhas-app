import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
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

  var selectedPagedIndex = 0;
  final List<Widget> pages = [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.yellow),
    Container(color: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
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
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: pages[selectedPagedIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 20.0,
        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.chat_bubble_outline),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.location_on),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.settings),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 65.0,
        height: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: DesignSystemColors.ligthPurple,
            onPressed: () {},
            child: Icon(
              Icons.ac_unit,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
