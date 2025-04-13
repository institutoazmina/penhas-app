import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/widgets/badges/user_badge_widget.dart';
import '../../data/models/chat_user_model.dart';
import '../../domain/entities/chat_badge_entity.dart';
import '../../domain/entities/chat_channel_message.dart';
import '../../domain/entities/chat_channel_session_entity.dart';
import '../../domain/entities/chat_user_entity.dart';
import '../../domain/states/chat_channel_state.dart';
import '../pages/channel/chat_channel_error_page.dart';
import '../pages/channel/chat_channel_initial_page.dart';
import '../pages/channel/chat_channel_message_composer.dart';
import '../pages/channel/chat_channel_message_page.dart';
import 'chat_channel_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.controller});

  final ChatChannelController controller;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatChannelController get controller => widget.controller;

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
        foregroundColor: DesignSystemColors.white,
        leadingWidth: 35,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: Modular.to.pop,
          ),
        ),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
        title: headerTitle(user),
        titleSpacing: 1.0,
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
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: _returnPadding(user.badges)),
                child: buildCloseBadgeWidget(user.badges),
              ),
              Padding(
                padding: EdgeInsets.only(right: _returnPadding(user.badges)),
                child: Text(user.nickname!, style: titleTextStyle),
              ),
              buildBadgeWidget(user.badges),
            ],
          ),
        )
      ],
    );
  }

  Widget buildBadgeWidget(List<ChatBadgeEntity> badges) {
    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }
    var onlyInlineBadges = <ChatBadgeEntity>[];

    for (final badge in badges) {
      if (badge.style != 'inline-block') {
        onlyInlineBadges.add(badge);
      }
    }

    return Row(
      children: onlyInlineBadges
          .map((badge) => Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: UserBadgeWidget(
                badgeDescription: badge.description,
                badgeImageUrl: badge.imageUrl,
                badgeName: badge.name,
                badgePopUp: badge.popUp,
                badgeShowDescription: badge.showDescription,
                isLightBackground: false,
                badgeImageUrlBlack: badge.imageUrlBlack,
              )))
          .toList(),
    );
  }

  Widget buildCloseBadgeWidget(List<ChatBadgeEntity> badges) {
    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }
    final emptyBadge = ChatBadgeModel(
        code: '',
        description: '',
        imageUrl: '',
        name: '',
        popUp: 0,
        showDescription: 0,
        style: '',
        imageUrlBlack: '');
    final badge = badges.firstWhere(
      (badge) => badge.style == 'inline-block',
      orElse: () => emptyBadge,
    );
    if (badge.style == '') {
      return const SizedBox.shrink();
    }
    return UserBadgeWidget(
      badgeDescription: badge.description,
      badgeImageUrl: badge.imageUrlBlack,
      badgeName: badge.name,
      badgePopUp: badge.popUp,
      badgeShowDescription: badge.showDescription,
      isLightBackground: false,
      badgeImageUrlBlack: badge.imageUrlBlack,
    );
  }

  double _returnPadding(List<ChatBadgeEntity> badges) {
    if (badges.isEmpty) {
      return 0.0;
    } else {
      return 4.0;
    }
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
  TextStyle get headerMessageTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.4,
        height: 1.3,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}
