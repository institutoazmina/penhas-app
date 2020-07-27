import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_state.dart';
import 'package:penhas/app/features/help_center/presentation/guardians/guardians_controller.dart';
import 'package:penhas/app/features/help_center/presentation/pages/guardian_error_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class GuardiansPage extends StatefulWidget {
  final String title;
  const GuardiansPage({Key key, this.title = "Guardians"}) : super(key: key);

  @override
  _GuardiansPageState createState() => _GuardiansPageState();
}

class _GuardiansPageState
    extends ModularState<GuardiansPage, GuardiansController>
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
      _showErrorMessage(),
      _showLoadProgress(),
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
      appBar: AppBar(
        title: Text('Meus Guardiões'),
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: PageProgressIndicator(
        progressState: _loadState,
        progressMessage: 'Carregando...',
        child: GestureDetector(
          onTap: () => _handleTap(context),
          onPanDown: (_) => _handleTap(context),
          child: SafeArea(
            child: Observer(
              builder: (context) => _buildBody(controller.currentState),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(GuardianState state) {
    return state.when(
      initial: () => Container(color: DesignSystemColors.white),
      loaded: () => _buildInputScreen(),
      error: (message) => GuardianErrorPage(
        message: message,
        onPressed: controller.loadPage,
      ),
      rateLimit: (maxLimit) => _buildInputScreen(),
    );
  }

  Widget _buildInputScreen() {
    return Container(
      color: Color.fromRGBO(248, 248, 248, 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 22.0),
        child: Column(
          children: <Widget>[
            // _headerMessage(),
            // _guardianNameInput(),
            // _guardianMobileInput(),
            // _description(),
            // _addGuardianButton(),
          ],
        ),
      ),
    );
  }

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

  _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
