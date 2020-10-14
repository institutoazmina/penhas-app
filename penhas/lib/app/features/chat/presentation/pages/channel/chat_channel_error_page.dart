import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatChannelErrorPage extends StatelessWidget {
  final String message;
  const ChatChannelErrorPage({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
        title: Text("Chat"),
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: 28.0,
                top: 12.0,
              ),
              child: Text(
                'Ocorreu um erro!',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Icon(
                Icons.warning,
                color: DesignSystemColors.white,
                size: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  letterSpacing: 0.44,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
