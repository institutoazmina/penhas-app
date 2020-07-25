import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_state.dart';
import 'package:penhas/app/features/help_center/presentation/new_guardian/new_guardian_controller.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class NewGuardianPage extends StatefulWidget {
  final String title;
  const NewGuardianPage({Key key, this.title = "NewGuardian"})
      : super(key: key);

  @override
  _NewGuardianPageState createState() => _NewGuardianPageState();
}

class _NewGuardianPageState
    extends ModularState<NewGuardianPage, NewGuardianController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      _showProgress(),
      _showErrorMessage(),
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
        title: Text('Novo Guardião'),
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: PageProgressIndicator(
        progressState: _loadState,
        progressMessage: 'Carregando...',
        child: SafeArea(
            child: Observer(
          builder: (context) => _buildBody(controller.currentState),
        )),
      ),
    );
  }

  Widget _buildBody(GuardianState state) {
    return state.when(
      initial: () => Container(color: DesignSystemColors.white),
      loaded: () => Container(color: Colors.cyan),
      error: (messages) => Container(color: Colors.redAccent),
      rateLimit: (maxLimit) => _rateLimit(maxLimit),
    );
  }

  Widget _rateLimit(int maxLimit) {
    return Container(color: Colors.yellow);
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.loadState, (PageProgressState status) {
      setState(() {
        _loadState = status;
      });
    });
  }
}
