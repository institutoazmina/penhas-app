import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: Container(
          decoration: DesignSystemWidget.background(),
          child: SafeArea(
              child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 78.0,
                    child: Text(
                      'Ambiente logado',
                      style: TextStyle(fontSize: 16.0, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
