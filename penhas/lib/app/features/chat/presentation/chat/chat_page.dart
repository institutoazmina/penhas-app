import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => showChatAction(context),
          ),
        ],
      ),
      body: Container(
        color: Colors.amber[100],
      ),
    );
  }
}

extension _ChatPageStateMethods on _ChatPageState {
  void showChatAction(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 5, bottom: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 150,
          child: Column(
            children: <Widget>[divider(context), ...buildActions()],
          ),
        );
      },
    );
  }

  Widget divider(BuildContext context) {
    return Container(
      width: fullWidth(context) * .2,
      height: 5,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  List<Widget> buildActions() {
    List<Widget> actions = [
      ListTile(
        leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_block.svg'),
        title: Text('Bloquear'),
        onTap: () => controller.blockChat(),
      ),
      ListTile(
        leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_delete.svg'),
        title: Text('Apagar'),
        onTap: () => controller.deleteSession(),
      ),
    ];

    return actions;
  }
}
