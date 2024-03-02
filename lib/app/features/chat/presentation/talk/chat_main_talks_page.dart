import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../support_center/presentation/pages/support_center_general_error.dart';
import '../../domain/entities/chat_main_tile_entity.dart';
import '../../domain/states/chat_main_talks_state.dart';
import '../pages/chat_assistant_card.dart';
import '../pages/chat_channel_card.dart';
import 'chat_main_talks_controller.dart';

class ChatMainTalksPage extends StatefulWidget {
  const ChatMainTalksPage({Key? key}) : super(key: key);

  @override
  _ChatMainTalksPageState createState() => _ChatMainTalksPageState();
}

class _ChatMainTalksPageState
    extends ModularState<ChatMainTalksPage, IChatMainTalksController> {
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

extension _ChatMainTalksPageBodyBuilder on _ChatMainTalksPageState {
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
            return buildCard(tiles[index]);
          },
        ),
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
                  icon: buildNetworkIcon(e),
                  channel: e,
                  onPressed: controller.openAssistantCard,
                ),
              )
              .toList()
        ],
      ),
    );
  }

  Widget buildChannelHeader(ChatMainChannelHeaderTile tile) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Text(
        tile.title,
        style: talksDividerTitleTextStyle,
      ),
    );
  }

  Widget buildChannelCard(ChatMainChannelCardTile tile) {
    return ChatChannelCard(
      channel: tile.channel,
      onPressed: controller.openChannel,
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

extension _ChatMainTalksPageTextStyle on _ChatMainTalksPageState {
  TextStyle get talksDividerTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        letterSpacing: 0.5,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
}
