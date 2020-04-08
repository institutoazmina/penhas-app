import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mastodon_dart/mastodon_dart.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'authentication_controller.dart';
import 'mastodon/auth_screen.dart';

class AuthenticationPage extends StatefulWidget {
  final String title;
  const AuthenticationPage({Key key, this.title = "Authentication"})
      : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState
    extends ModularState<AuthenticationPage, AuthenticationController> {
  //use 'controller' variable to access controller

  final instance = Uri.parse("https://mastodon.appcivico.com");

  @override
  Widget build(BuildContext context) {
    return Provider<Mastodon>(
      create: (_) => Mastodon(
        instance,
        websocketFactory: (uri) => IOWebSocketChannel.connect(uri),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          cardTheme: CardTheme(elevation: 0.3),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.blue,
          ),
        ),
        home: AuthScreen(),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: Column(
    //     children: <Widget>[],
    //   ),
    // );
  }
}
