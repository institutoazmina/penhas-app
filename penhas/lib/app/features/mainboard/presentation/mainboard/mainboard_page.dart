import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
import 'package:penhas/app/shared/design_system/widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignSystemColors.ligthPurple,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Icon(
            DesignSystemLogo.penhasLogo,
            color: Colors.white,
            size: 22,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () => {},
          )
        ],
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Container(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: 80),
                SizedBox(
                  height: 78.0,
                  child: Text(
                    'Ambiente logado',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                RaisedButton(
                  onPressed: () => controller.logoutPressed(),
                  elevation: 0,
                  color: DesignSystemColors.ligthPurple,
                  child: Text(
                    "SAIR",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
