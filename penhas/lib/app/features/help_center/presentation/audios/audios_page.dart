import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_play_tile_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/audio_tile_action.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';
import 'package:penhas/app/features/help_center/presentation/pages/audio/audio_play_widget.dart';
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
      _showActionSheet(),
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
        elevation: 0.0,
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

  ReactionDisposer _showActionSheet() {
    return reaction((_) => controller.actionSheetState,
        (AudioTileAction actionSheetState) {
      actionSheetState.when(
        initial: () {},
        notice: (message) => _showActionNotice(message),
        actionSheet: (action) => _actionSheet(action),
      );
    });
  }

  void _showActionNotice(String message) {
    if (message == null || message.isEmpty) return;

    Modular.to.showDialog(
      child: AlertDialog(
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
            child: Text('Ok'),
            onPressed: () {
              Modular.to.pop();
            },
          )
        ],
      ),
      barrierDismissible: true,
    );
  }

  void _actionSheet(AudioEntity audio) async {
    final BuildContext _context = _scaffoldKey.currentContext;
    await showModalBottomSheet(
      context: _context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 5, bottom: 0),
          decoration: BoxDecoration(
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
              ListTile(
                leading: SvgPicture.asset(
                    'assets/images/svg/tweet_action/tweet_action_delete.svg'),
                title: Text('Apagar'),
                onTap: () {
                  Navigator.of(_context).pop();
                  controller.delete(audio);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  double _fullWidth() {
    return MediaQuery.of(_scaffoldKey.currentContext).size.width;
  }

  Widget _buildDivider() {
    return Container(
      width: _fullWidth() * .2,
      height: 5,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
