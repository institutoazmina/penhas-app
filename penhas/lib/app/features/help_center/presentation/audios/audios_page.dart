import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_play_tile_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';
import 'package:penhas/app/features/help_center/presentation/pages/audio/audio_play_widget.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_error_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'audios_controller.dart';

class AudiosPage extends StatefulWidget {
  final String title;
  const AudiosPage({Key key, this.title = "Audios"}) : super(key: key);

  @override
  _AudiosPageState createState() => _AudiosPageState();
}

class _AudiosPageState extends ModularState<AudiosPage, AudiosController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  PageProgressState _loadState = PageProgressState.initial;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    _disposers.forEach((d) => d());
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Minhas gravações'),
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

  Widget _buildBody(AudiosState state) {
    return state.when(
      initial: () => _empty(),
      loaded: (tiles) => _buildInputScreen(tiles),
      error: (message) => GuardianErrorPage(
        message: message,
        onPressed: controller.loadPage,
      ),
    );
  }

  Widget _buildInputScreen(List<AudioPlayTileEntity> tiles) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 22),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async => controller.loadPage(),
          child: ListView.builder(
              itemCount: tiles.length,
              itemBuilder: (context, index) {
                return AudioPlayWidget(audioPlay: tiles[index]);
              }),
        ),
      ),
    );
  }

  Widget _empty() => Container(width: 0.0, height: 0.0);

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
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
