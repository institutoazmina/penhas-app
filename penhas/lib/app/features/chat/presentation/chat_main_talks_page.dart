import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_main_tile_entity.dart';
import 'package:penhas/app/features/chat/domain/states/chat_main_talks_state.dart';
import 'package:penhas/app/features/chat/presentation/pages/chat_assistant_card.dart';
import 'package:penhas/app/features/chat/presentation/pages/chat_channel_card.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'chat_main_talks_controller.dart';

class ChatMainTalksPage extends StatefulWidget {
  const ChatMainTalksPage({Key key}) : super(key: key);

  @override
  _ChatMainTalksPageState createState() => _ChatMainTalksPageState();
}

class _ChatMainTalksPageState
    extends ModularState<ChatMainTalksPage, ChatMainTalksController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      color: DesignSystemColors.systemBackgroundColor,
      child: Observer(
        builder: (_) {
          return bodyBuilder(controller.currentState);
        },
      ),
    );
  }
}

extension _ChatMainTalksPageBodyBuilder on _ChatMainTalksPageState {
  Widget bodyBuilder(ChatMainTalksState state) {
    return state.when(
      initial: () => empty(),
      loading: () => loading(),
      loaded: (tiles) => loaded(tiles),
      error: (message) => empty(),
    );
  }

  Widget empty() => Container(color: DesignSystemColors.systemBackgroundColor);

  Widget loading() {
    return PageProgressIndicator(
        progressMessage: 'Carregando...',
        child: Container(color: DesignSystemColors.systemBackgroundColor),
        progressState: PageProgressState.loading);
  }

  Widget loaded(List<ChatMainTileEntity> tiles) {
    return RefreshIndicator(
      onRefresh: () async => controller.reload(),
      child: ListView.builder(
        itemCount: tiles.length,
        itemBuilder: (context, index) {
          return buildCard(tiles[index]);
        },
      ),
    );
  }

  Widget buildCard(ChatMainTileEntity tile) {
    if (tile is ChatMainAssistantCardTile) {
      return buildAssistantCard(tile);
    }

    if (tile is ChatMainChannelHeaderTile) {
      return buildChannelHeader(tile);
    }

    if (tile is ChatMainChannelCardTile) {
      return buildChannelCard(tile);
    }

    return Container();
  }

  Widget buildAssistantCard(ChatMainAssistantCardTile tile) {
    if (tile.cards.isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...tile.cards
              .map(
                (e) => ChatAssistantCard(
                  title: e.title,
                  description: e.content,
                  icon: Image.network(
                    e.channel.user.avatar,
                    width: 40,
                    height: 40,
                  ),
                  channel: e.channel,
                  onPressed: controller.openChannel,
                ),
              )
              .toList()
        ],
      ),
    );
  }

  Widget buildChannelHeader(ChatMainChannelHeaderTile tile) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Text(
        tile.title,
        style: talksDividerTitleTextStyle,
      ),
    );
  }

  Widget buildChannelCard(ChatMainChannelCardTile tile) {
    return ChatChannelCard(channel: tile.channel);
  }
}

extension _ChatMainTalksPageTextStyle on _ChatMainTalksPageState {
  TextStyle get talksDividerTitleTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontSize: 16.0,
      letterSpacing: 0.5,
      color: DesignSystemColors.darkIndigoThree,
      fontWeight: FontWeight.bold);
}
