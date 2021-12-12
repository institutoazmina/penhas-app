import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/extension/asuka.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_play_tile_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/audio_playing.dart';
import 'package:penhas/app/features/help_center/domain/states/audio_tile_action.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_controller.dart';
import 'package:penhas/app/features/help_center/presentation/pages/audio/audio_play_widget.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_error_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class AudiosPage extends StatefulWidget {
  const AudiosPage({Key? key, this.title = 'Audios'}) : super(key: key);

  final String title;

  const AudiosPage({Key? key, this.title = "Audios"}) : super(key: key);

  @override
  _AudiosPageState createState() => _AudiosPageState();
}

class _AudiosPageState extends ModularState<AudiosPage, AudiosController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  PageProgressState _loadState = PageProgressState.initial;
  AudioEntity? _playingAudio;
  AudioEntity? _selectingAudioMenu;

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
      _showActionSheet(),
      _showAudioPlayStatus()
    ];
  }

  @override
  void dispose() {
    _disposers!.forEach((d) => d());
    controller.dispose();
    _playingAudio = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Minhas gravações'),
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
        padding: const EdgeInsets.only(top: 22),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async => controller.loadPage(),
          child: ListView.builder(
              itemCount: tiles.length,
              itemBuilder: (context, index) {
                final audio = tiles[index];
                final isPlaying = audio.audio == _playingAudio;
                final backgroundColor = _selectingAudioMenu == audio.audio
                    ? DesignSystemColors.blueyGrey
                    : Colors.transparent;

                return AudioPlayWidget(
                    audioPlay: tiles[index],
                    isPlaying: isPlaying,
                    backgroundColor: backgroundColor);
              }),
        ),
      ),
    );
  }

  Widget _empty() => const SizedBox(width: 0.0, height: 0.0);

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

  ReactionDisposer _showActionSheet() {
    return reaction((_) => controller.actionSheetState,
        (AudioTileAction actionSheetState) {
      actionSheetState.when(
        initial: () {},
        notice: (message) => _showActionNotice(message),
        actionSheet: (audio) {
          setState(() {
            _selectingAudioMenu = audio;
          });
          _actionSheet(audio);
        },
      );
    });
  }

  ReactionDisposer _showAudioPlayStatus() {
    return reaction((_) => controller.playingAudioState,
        (AudioPlaying? actionSheetState) {
      actionSheetState!.when(
        none: () => setState(() {
          _playingAudio = null;
        }),
        playing: (audio) => setState(() {
          _playingAudio = audio;
        }),
      );
    });
  }

  void _showActionNotice(String? message) {
    if (message == null || message.isEmpty) return;

    Modular.to.showDialog(
      builder: (_) => AlertDialog(
        title: Text('Informação', style: kTextStyleAlertDialogTitle),
        content: Text(
          message,
          style: kTextStyleAlertDialogDescription,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void _actionSheet(AudioEntity audio) async {
    final BuildContext _context = _scaffoldKey.currentContext!;
    await showModalBottomSheet(
      context: _context,
      backgroundColor: Colors.transparent,
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
          height: 200,
          child: Column(
            children: <Widget>[
              _buildDivider(),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Para solicitar o download do arquivo de áudio entrar em contato com PenhaS pelo chat ou email penhas@azmina.com.br',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/images/svg/tweet_action/tweet_action_delete.svg',
                ),
                title: const Text('Apagar'),
                onTap: () {
                  Navigator.of(_context).pop();
                  controller.delete(audio);
                },
              ),
            ],
          ),
        );
      },
    ).whenComplete(() => setState(() => _selectingAudioMenu = null));
  }

  double _fullWidth() {
    return MediaQuery.of(_scaffoldKey.currentContext!).size.width;
  }

  Widget _buildDivider() {
    return Container(
      width: _fullWidth() * .2,
      height: 5,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
