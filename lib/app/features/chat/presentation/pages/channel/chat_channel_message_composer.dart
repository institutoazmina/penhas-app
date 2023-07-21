import 'package:flutter/material.dart';

import '../../../../../shared/design_system/button_shape.dart';
import '../../../../../shared/design_system/colors.dart';
import '../../chat/chat_channel_compose_type.dart';

class ChatChannelMessageComposer extends StatefulWidget {
  const ChatChannelMessageComposer({
    Key? key,
    required this.composerType,
    required this.onSentMessage,
    required this.onUnblockChannel,
  }) : super(key: key);

  final ChatChannelComposerType composerType;
  final void Function(String) onSentMessage;
  final void Function() onUnblockChannel;

  @override
  _ChatChannelMessageComposerState createState() =>
      _ChatChannelMessageComposerState();
}

class _ChatChannelMessageComposerState
    extends State<ChatChannelMessageComposer> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget context = _sentMessage();
    switch (widget.composerType) {
      case ChatChannelComposerType.blockedByMe:
        context = _blockedByMe();
        break;
      case ChatChannelComposerType.blockedByOwner:
        context = _blockedByOwner();
        break;
      case ChatChannelComposerType.sentMessage:
        context = _sentMessage();
        break;
    }

    return context;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget _sentMessage() {
    return Container(
      height: 60.0,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              decoration: const InputDecoration.collapsed(
                hintText: 'Digite uma mensagem',
              ),
              textCapitalization: TextCapitalization.sentences,
              controller: _textController,
              onSubmitted: (t) => _submitMessageAction(context),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _submitMessageAction(context),
          ),
        ],
      ),
    );
  }

  Widget _blockedByMe() {
    return Container(
      height: 60.0,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 44,
              width: 200,
              child: RaisedButton(
                onPressed: widget.onUnblockChannel,
                elevation: 0,
                color: DesignSystemColors.ligthPurple,
                shape: kButtonShapeFilled,
                child: Text(
                  ' Desbloquear o chat ',
                  style: buttomTitleStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blockedByOwner() {
    return Container(
      height: 60.0,
      color: Colors.grey[200],
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Center(
              child: Text(
                'Você está bloqueado para utilizar este chat',
                style: blockedStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitMessageAction(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    widget.onSentMessage(_textController.text);
    _textController.clear();
  }
}

extension _ChatChannelMessageComposerStatePrivate
    on _ChatChannelMessageComposerState {
  TextStyle get buttomTitleStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get blockedStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.blueyGrey,
        fontWeight: FontWeight.bold,
      );
}
