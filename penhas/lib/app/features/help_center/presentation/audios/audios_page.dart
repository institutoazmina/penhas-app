import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_error_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

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

  Widget _buildInputScreen(List<AudioEntity> tiles) {
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
                return _buildAudioPlayer(tiles[index], (index + 1));
              }),
        ),
      ),
    );
  }

  Widget _buildAudioPlayer(AudioEntity audio, int index) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[350]),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.play_circle_filled,
                        size: 40,
                      ),
                      onPressed: null),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      audio.audioDuration,
                      style: kTextStyleAudioDuration,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("Gravação $index",
                              style: kTextStyleAudioTitle)),
                      Expanded(
                        child: Text(
                          DateFormat.yMd('pt_BR').format(audio.createdAt),
                          style: kTextStyleAudioTime,
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  Text('Download requisitado, aguardando autorização',
                      style: kTextStyleAudioDescription),
                ],
              ),
            ),
          ),
          Expanded(
              child: SizedBox(
                  height: 44,
                  width: 44,
                  child:
                      IconButton(icon: Icon(Icons.more_vert), onPressed: null)))
        ],
      ),
    );
  }

  Widget _empty() => Container(color: DesignSystemColors.white);

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
