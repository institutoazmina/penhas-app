import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'feed_routing_perfil_chat_controller.dart';

class FeedRoutingPerfilChatPage extends StatefulWidget {
  FeedRoutingPerfilChatPage({Key key}) : super(key: key);

  @override
  _FeedRoutingPerfilChatPageState createState() =>
      _FeedRoutingPerfilChatPageState();
}

class _FeedRoutingPerfilChatPageState extends ModularState<
    FeedRoutingPerfilChatPage, FeedRoutingPerfilChatController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
    );
  }
}
