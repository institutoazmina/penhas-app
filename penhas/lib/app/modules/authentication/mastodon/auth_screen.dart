import 'package:flutter/material.dart';

import 'package:mastodon_dart/mastodon_dart.dart';
import 'package:provider/provider.dart';

import 'auth_builder.dart';
import 'auth_storage.dart';
import 'timeline_screen.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _controller = TextEditingController();
  AuthBloc bloc;

  bool canSubmit = false;

  void _handleChanged(String text) {
    setState(() {
      canSubmit = text.length > 10;
    });
  }

  @override
  void didChangeDependencies() {
    bloc = AuthBloc(
      Provider.of<Mastodon>(context),
      Uri.parse("https://github.com/lukepighetti/mastodon-flutter"),
      storage: AuthStorage(),
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: AuthBuilder(
        bloc: bloc,
        builder: (_, launchUrl, submitCode, token, account) {
          final isAuthenticated = account != null;

          if (isAuthenticated) {
            Future.delayed(Duration(seconds: 1)).then((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (_) => TimelineScreen(account: account)),
              );
            });
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  enabled: submitCode != null,
                  controller: _controller,
                  style: Theme.of(context).textTheme.headline,
                  onChanged: _handleChanged,
                  decoration: InputDecoration(
                    hintText: token ?? "Paste code here",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Get login code"),
                    onPressed: launchUrl,
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                  RaisedButton(
                    child: Text("Submit code"),
                    onPressed:
                        canSubmit ? () => submitCode(_controller.text) : null,
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
