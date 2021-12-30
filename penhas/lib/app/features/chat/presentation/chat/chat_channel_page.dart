import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_state.dart';
import 'package:penhas/app/features/chat/presentation/chat/chat_channel_controller.dart';
import 'package:penhas/app/features/chat/presentation/pages/channel/chat_channel_error_page.dart';
import 'package:penhas/app/features/chat/presentation/pages/channel/chat_channel_initial_page.dart';
import 'package:penhas/app/features/chat/presentation/pages/channel/chat_channel_message_composer.dart';
import 'package:penhas/app/features/chat/presentation/pages/channel/chat_channel_message_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatChannelController> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return pageBuilder(controller.currentState);
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

extension _ChatPageStateMethods on _ChatPageState {
  Widget pageBuilder(ChatChannelState state) {
    return state.when(
      initial: () => const ChatChannelInitialPage(),
      error: (error) => ChatChannelErrorPage(message: error),
      loaded: () => startingChannel(controller.user, controller.metadata),
    );
  }

  Widget startingChannel(
    ChatUserEntity user,
    ChatChannelSessionMetadataEntity metadata,
  ) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
        title: headerTitle(user),
        titleSpacing: 2.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showChatAction(context, metadata),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            headerMessage(metadata.headerMessage),
            Expanded(child: chatMessages(controller.channelMessages)),
            ChatChannelMessageComposer(
              composerType: controller.composerType,
              onSentMessage: controller.sentMessage,
              onUnblockChannel: controller.unBlockChat,
            ),
          ],
        ),
      ),
    );
  }

  Widget headerMessage(String? message) {
    if (message == null || message.isEmpty) {
      return Container();
    }

    return Container(
      color: DesignSystemColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Text(
        message,
        style: headerMessageTextStyle,
      ),
    );
  }

  Widget chatMessages(List<ChatChannelMessage> messages) {
    return Container(
      color: DesignSystemColors.systemBackgroundColor,
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.only(top: 8.0),
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          final message = messages[index];
          return ChatChannelMessagePage(
            content: message,
          );
        },
      ),
    );
  }

  Widget headerTitle(ChatUserEntity user) {
    Widget avatar;
    if (user.avatar!.toLowerCase().endsWith('.svg')) {
      avatar = SvgPicture.network(user.avatar!, height: 22, width: 22);
    } else {
      avatar = Image.network(user.avatar!);
    }

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white38,
            radius: 16,
            child: avatar,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.nickname!, style: titleTextStyle),
            Text(user.activity!, style: statusTextStyle),
          ],
        )
      ],
    );
  }

  Future<void> showChatAction(
    BuildContext context,
    ChatChannelSessionMetadataEntity metadata,
  ) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 150,
          child: Column(
            children: <Widget>[
              divider(context),
              ...buildActions(context, metadata)
            ],
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
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  List<Widget> buildActions(
    BuildContext context,
    ChatChannelSessionMetadataEntity metadata,
  ) {
    final List<Widget> actions = [];

    if (metadata.canSendMessage) {
      actions.add(
        ListTile(
          leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_block.svg',
          ),
          title: const Text('Bloquear'),
          onTap: () {
            Navigator.of(context).pop();
            controller.blockChat();
          },
        ),
      );
    }

    actions.add(
      ListTile(
        leading: SvgPicture.asset(
          'assets/images/svg/tweet_action/tweet_action_delete.svg',
        ),
        title: const Text('Apagar'),
        onTap: () {
          Navigator.of(context).pop();
          controller.deleteSession();
        },
      ),
    );

    return actions;
  }
}

extension _ChatPageStateStyle on _ChatPageState {
  TextStyle get titleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.bold,
      );
  TextStyle get statusTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 12.0,
        letterSpacing: 0.4,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.normal,
      );

  TextStyle get headerMessageTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        height: 1.3,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}
