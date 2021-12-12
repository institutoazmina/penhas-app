import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_main_tile_entity.dart';
import 'package:penhas/app/features/chat/domain/states/chat_main_talks_state.dart';
import 'package:penhas/app/features/chat/presentation/pages/chat_people_card.dart';
import 'package:penhas/app/features/chat/presentation/pages/chat_people_filter_card.dart';
import 'package:penhas/app/features/chat/presentation/people/chat_main_people_controller.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ChatMainPeoplePage extends StatefulWidget {
  const ChatMainPeoplePage({Key? key}) : super(key: key);

  @override
  _ChatMainPeoplePageState createState() => _ChatMainPeoplePageState();
}

class _ChatMainPeoplePageState
    extends ModularState<ChatMainPeoplePage, ChatMainPeopleController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: DesignSystemColors.systemBackgroundColor,
      child: Observer(
        builder: (_) {
          return bodyBuilder(controller.currentState);
        },
      ),
    );
  }
}

extension _ChatMainPeoplePageBodyBuilder on _ChatMainPeoplePageState {
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
    if (tile is ChatMainPeopleFilterCardTile) {
      return buildPeopleFilterCard(tile);
    }

    if (tile is ChatMainPeopleCardTile) {
      return buildPeopleCard(tile);
    }

    return Container();
  }

  Widget buildPeopleFilterCard(ChatMainPeopleFilterCardTile tile) {
    return ChatPeopleFilterCard(
      onPressed: () async => controller.filter(),
      totalOfFilter: tile.totalFiltersSeleted,
    );
  }

  Widget buildPeopleCard(ChatMainPeopleCardTile tile) {
    return ChatPeopleCard(
      person: tile.person,
      onPressed: controller.profile,
    );
  }
}
