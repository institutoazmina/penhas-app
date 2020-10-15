import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_message.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';
import 'package:penhas/app/features/chat/domain/states/chat_channel_state.dart';
import 'package:penhas/app/features/chat/presentation/pages/channel/chat_channel_error_page.dart';
import 'package:penhas/app/features/chat/presentation/pages/channel/chat_channel_initial_page.dart';
import 'package:penhas/app/features/chat/presentation/pages/channel/chat_channel_message_composer.dart';
import 'package:penhas/app/features/chat/presentation/pages/channel/chat_channel_message_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'chat_channel_controller.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatChannelController> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return pageBuilder(controller.currentState);
    });
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
      initial: () => ChatChannelInitialPage(),
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
            icon: Icon(Icons.more_vert),
            onPressed: () => showChatAction(context),
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

/*
  RefreshIndicator _buildRefreshIndicator() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      notificationPredicate: _handleScrollNotification,
      child: ListView.builder(
        itemCount: controller.listTweets.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return _buildTweetItem(
            controller.listTweets[index],
            context,
          );
        },
      ),
    );
  }
*/

  Widget headerMessage(String message) {
    if (message == null || message.isEmpty) {
      return Container();
    }

    return Container(
      color: DesignSystemColors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
        padding: EdgeInsets.only(top: 8.0),
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
    if (user.avatar.toLowerCase().endsWith('.svg')) {
      avatar = SvgPicture.network(user.avatar, height: 22, width: 22);
    } else {
      avatar = Image.network(user.avatar);
    }

    return Container(
      child: Row(
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
              Text(user.nickname, style: titleTextStyle),
              Text(user.activity, style: statusTextStyle),
            ],
          )
        ],
      ),
    );
  }

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
            children: <Widget>[divider(context), ...buildActions(context)],
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

  List<Widget> buildActions(BuildContext context) {
    List<Widget> actions = [
      ListTile(
        leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_block.svg'),
        title: Text('Bloquear'),
        onTap: () {
          Navigator.of(context).pop();
          controller.blockChat();
        },
      ),
      ListTile(
        leading: SvgPicture.asset(
            'assets/images/svg/tweet_action/tweet_action_delete.svg'),
        title: Text('Apagar'),
        onTap: () {
          Navigator.of(context).pop();
          controller.deleteSession();
        },
      ),
    ];

    return actions;
  }
}

extension _ChatPageStateStyle on _ChatPageState {
  TextStyle get titleTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.5,
      color: DesignSystemColors.white,
      fontWeight: FontWeight.bold);
  TextStyle get statusTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 12.0,
      letterSpacing: 0.4,
      color: DesignSystemColors.white,
      fontWeight: FontWeight.normal);

  TextStyle get headerMessageTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.4,
      height: 1.3,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.normal);
}
