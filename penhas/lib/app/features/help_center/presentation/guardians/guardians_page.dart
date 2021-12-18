import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_tile_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_state.dart';
import 'package:penhas/app/features/help_center/presentation/guardians/guardians_controller.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_error_page.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_tile_action_card.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_tile_description.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_tile_empty_card.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_tile_header.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class GuardiansPage extends StatefulWidget {
  final String title;
  const GuardiansPage({Key? key, this.title = 'Guardians'}) : super(key: key);

  @override
  _GuardiansPageState createState() => _GuardiansPageState();
}

class _GuardiansPageState
    extends ModularState<GuardiansPage, GuardiansController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  PageProgressState _loadState = PageProgressState.initial;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.loadPage();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showErrorMessage(),
      _showLoadProgress(),
      _showUpdateProgress(),
    ];
  }

  @override
  void dispose() {
    for (final d in _disposers!) {
      d();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Meus Guardiões'),
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: PageProgressIndicator(
        progressState: _loadState,
        progressMessage: 'Carregando...',
        child: SafeArea(
          child: Observer(
            builder: (context) => _buildBody(controller.currentState),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(GuardianState state) {
    return state.when(
      initial: () => _empty(),
      loaded: (tiles) => _buildInputScreen(tiles),
      error: (message) => GuardianErrorPage(
        message: message,
        onPressed: controller.loadPage,
      ),
    );
  }

  Widget _buildInputScreen(List<GuardianTileEntity> tiles) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 22.0),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async => controller.loadPage(),
          child: ListView.builder(
              itemCount: tiles.length,
              itemBuilder: (context, index) {
                final tile = tiles[index];
                if (tile is GuardianTileHeaderEntity) {
                  return GuardianTileHeader(title: tile.title);
                }
                if (tile is GuardianTileDescriptionEntity) {
                  return GuardianTileDescription(description: tile.description);
                }
                if (tile is GuardianTileCardEntity) {
                  return GuardianTileActionCard(
                    card: tile,
                  );
                }
                if (tile is GuardianTileEmptyCardEntity) {
                  return GuardianTileEmptyCard(
                    card: tile,
                  );
                }
                return Container(
                  height: 60,
                  color: Colors.black,
                );
              },),
        ),
      ),
    );
  }

  Widget _empty() => Container(color: DesignSystemColors.white);

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showLoadProgress() {
    return reaction((_) => controller.loadState, (PageProgressState status) {
      setState(() {
        _loadState = status;
      });
    });
  }

  ReactionDisposer _showUpdateProgress() {
    return reaction((_) => controller.updateState, (PageProgressState status) {
      setState(() {
        _loadState = status;
      });
    });
  }
}
