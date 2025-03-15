import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../support_center/presentation/pages/support_center_general_error.dart';
import '../../domain/entities/chat_main_tile_entity.dart';
import '../../domain/states/chat_main_talks_state.dart';
import '../pages/chat_assistant_card.dart';
import '../pages/chat_channel_card.dart';
import 'chat_main_talks_controller.dart';

class ChatMainTalksPage extends StatefulWidget {
  const ChatMainTalksPage({super.key, required this.controller});

  final ChatMainTalksController controller;

  @override
  ChatMainTalksPageState createState() => ChatMainTalksPageState();
}

class ChatMainTalksPageState extends State<ChatMainTalksPage> {
  ChatMainTalksController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignSystemColors.systemBackgroundColor,
      child: Observer(
        builder: (_) {
          return bodyBuilder(controller.currentState);
        },
      ),
    );
  }
}

extension _ChatMainTalksPageBodyBuilder on ChatMainTalksPageState {
  Widget bodyBuilder(ChatMainTalksState state) {
    return state.when(
      initial: () => empty(),
      loading: () => loading(),
      loaded: (tiles) => loaded(tiles),
      error: (message) => SupportCenterGeneralError(
        message: message,
        onPressed: () => controller.reload(),
      ),
    );
  }

  Widget empty() => Container(color: DesignSystemColors.systemBackgroundColor);

  Widget loading() {
    return PageProgressIndicator(
      progressMessage: 'Carregando...',
      progressState: PageProgressState.loading,
      child: Container(color: DesignSystemColors.systemBackgroundColor),
    );
  }

  Widget loaded(List<ChatMainTileEntity> tiles) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: RefreshIndicator(
        onRefresh: () async => controller.reload(),
        child: ListView.builder(
          itemCount: tiles.length,
          itemBuilder: (context, index) {
            return buildCard(tiles[index], index, tiles.length);
          },
        ),
      ),
    );
  }

  Widget buildCard(ChatMainTileEntity tile, int currentTile, int totalTiles) {
    if (tile is ChatMainAssistantCardTile) {
      return buildAssistantCard(tile);
    }

    if (tile is ChatMainChannelHeaderTile) {
      return buildChannelHeader(tile);
    }

    if (tile is ChatMainChannelCardTile) {
      if (currentTile == totalTiles - 1) {
        return buildChannelNoDividerCard(tile);
      } else {
        return buildChannelCard(tile);
      }
    }

    return Container();
  }

  Widget buildAssistantCard(ChatMainAssistantCardTile tile) {
    if (tile.cards.isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
                'Precisa de ajuda? Entre em contato com o nosso suporte',
                style: kTextStyleFeedTweetTitle),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...tile.cards.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ChatAssistantCard(
                    title: e.title,
                    description: e.content,
                    icon: buildNetworkIcon(e),
                    channel: e,
                    onPressed: controller.openAssistantCard,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildChannelHeader(ChatMainChannelHeaderTile tile) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _builderDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              tile.title,
              style: talksDividerTitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChannelCard(ChatMainChannelCardTile tile) {
    return Column(
      children: [
        ChatChannelCard(
          channel: tile.channel,
          onPressed: controller.openChannel,
        ),
        _builderDivider(),
      ],
    );
  }

  Widget buildChannelNoDividerCard(ChatMainChannelCardTile tile) {
    return Column(
      children: [
        ChatChannelCard(
          channel: tile.channel,
          onPressed: controller.openChannel,
        ),
      ],
    );
  }

  Widget _builderDivider() {
    return const Divider(
      color: DesignSystemColors.blueyGrey,
      thickness: 1.0,
      indent: 20.0,
      endIndent: 20.0,
      height: 20,
    );
  }

  Widget buildNetworkIcon(ChatMainSupportTile data) {
    if (data.channel?.user.avatar == null) {
      return Image.asset(
        'assets/images/chat/penhasAssistant/penhasAssistant.png',
        height: 40,
        width: 40,
      );
    }

    return Image.network(
      data.channel!.user.avatar!,
      width: 40,
      height: 40,
    );
  }
}

extension _ChatMainTalksPageTextStyle on ChatMainTalksPageState {
  TextStyle get talksDividerTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
}
