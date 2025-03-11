import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../domain/entities/guardian_tile_entity.dart';
import '../../domain/states/guardian_state.dart';
import '../pages/guardian_error_page.dart';
import '../pages/guardian_tile_action_card.dart';
import '../pages/guardian_tile_description.dart';
import '../pages/guardian_tile_empty_card.dart';
import '../pages/guardian_tile_header.dart';
import 'guardians_controller.dart';

class GuardiansPage extends StatefulWidget {
  const GuardiansPage(
      {Key? key, this.title = 'Guardians', required this.controller})
      : super(key: key);

  final GuardiansController controller;

  final String title;

  @override
  GuardiansPageState createState() => GuardiansPageState();
}

class GuardiansPageState extends State<GuardiansPage> with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  PageProgressState _loadState = PageProgressState.initial;
  GuardiansController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.loadPage();
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
            builder: (context) => _buildBody(_controller.currentState),
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
        onPressed: _controller.loadPage,
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
          onRefresh: () async => _controller.loadPage(),
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
            },
          ),
        ),
      ),
    );
  }

  Widget _empty() => Container(color: DesignSystemColors.white);

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => _controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showLoadProgress() {
    return reaction((_) => _controller.loadState, (PageProgressState status) {
      setState(() {
        _loadState = status;
      });
    });
  }

  ReactionDisposer _showUpdateProgress() {
    return reaction((_) => _controller.updateState, (PageProgressState status) {
      setState(() {
        _loadState = status;
      });
    });
  }
}
