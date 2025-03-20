import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../chat/chat_channel_compose_type.dart';

class ChatChannelMessageComposer extends StatefulWidget {
  const ChatChannelMessageComposer({
    super.key,
    required this.composerType,
    required this.onSentMessage,
    required this.onUnblockChannel,
  });

  final ChatChannelComposerType composerType;
  final void Function(String) onSentMessage;
  final void Function() onUnblockChannel;

  @override
  ChatChannelMessageComposerState createState() =>
      ChatChannelMessageComposerState();
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
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 8),
      child: Container(
        height: 40.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 5.0),
              blurRadius: 1.0,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Digite uma mensagem',
                ),
                textInputAction: TextInputAction.send,
                textCapitalization: TextCapitalization.sentences,
                controller: _textController,
                onSubmitted: (t) => _submitMessageAction(context),
              ),
            ),
          ],
        ),
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
              child: PenhasButton.roundedFilled(
                onPressed: widget.onUnblockChannel,
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
    on ChatChannelMessageComposerState {
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
