import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/extension/asuka.dart';
import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../authentication/presentation/shared/input_box_style.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../authentication/presentation/shared/single_text_input.dart';
import '../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../domain/states/guardian_alert_state.dart';
import '../../domain/states/new_guardian_state.dart';
import '../pages/guardian_error_page.dart';
import '../pages/guardian_rate_limit_page.dart';
import 'new_guardian_controller.dart';

class NewGuardianPage extends StatefulWidget {
  const NewGuardianPage({Key? key, this.title = 'NewGuardian'})
      : super(key: key);

  final String title;

  @override
  _NewGuardianPageState createState() => _NewGuardianPageState();
}

class _NewGuardianPageState
    extends ModularState<NewGuardianPage, NewGuardianController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
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
      _showCreateProgress(),
      _showAlert(),
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
        title: const Text('Novo Guardião'),
        backgroundColor: DesignSystemColors.ligthPurple,
      ),
      body: PageProgressIndicator(
        progressState: _loadState,
        progressMessage: 'Carregando...',
        child: GestureDetector(
          onTap: () => _handleTap(context),
          onPanDown: (_) => _handleTap(context),
          child: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Observer(
                    builder: (context) => _buildBody(controller.currentState),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(NewGuardianState state) {
    return state.when(
      initial: () => Container(color: DesignSystemColors.white),
      loaded: () => _buildInputScreen(),
      error: (message) => GuardianErrorPage(
        message: message,
        onPressed: controller.loadPage,
      ),
      rateLimit: (maxLimit) => GuardianRateLimitPage(maxLimit: maxLimit),
    );
  }

  Widget _buildInputScreen() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 22.0),
        child: Column(
          children: <Widget>[
            _headerMessage(),
            _guardianNameInput(),
            _guardianMobileInput(),
            _description(),
            _addGuardianButton(),
          ],
        ),
      ),
    );
  }

  Widget _headerMessage() {
    return RichText(
      text: const TextSpan(
        text: 'Cadastre uma pessoa próxima e de confiança para ser guardião.',
        style: kTextStyleGuardianBodyTextStyle,
        children: <TextSpan>[
          TextSpan(
            text: ' Não precisa ser usuário do PenhaS.',
            style: kTextStyleGuardianBodyTextBoldStyle,
          )
        ],
      ),
    );
  }

  Widget _guardianNameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Observer(
        builder: (_) {
          return SingleTextInput(
            style: kTextStyleGreyDefaultTextFieldLabelStyle,
            onChanged: controller.setGuardianName,
            boxDecoration: PurpleBoxDecorationStyle(
              labelText: 'Nome do guardião',
              errorText: controller.warningName,
            ),
          );
        },
      ),
    );
  }

  Widget _guardianMobileInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Observer(
        builder: (_) {
          return SingleTextInput(
            style: kTextStyleGreyDefaultTextFieldLabelStyle,
            keyboardType: TextInputType.phone,
            onChanged: controller.setGuardianMobile,
            boxDecoration: PurpleBoxDecorationStyle(
              labelText: 'Celular',
              hintText: 'Número do celular com o DDD',
              errorText: controller.warningMobile,
            ),
          );
        },
      ),
    );
  }

  Widget _description() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: RichText(
            text: const TextSpan(
              text:
                  '• Para que esta pessoa se torne sua guardiã, é preciso que ela',
              style: kTextStyleGuardianBodyTextStyle,
              children: <TextSpan>[
                TextSpan(
                  text: ' aceite o convite ',
                  style: kTextStyleGuardianBodyTextBoldStyle,
                ),
                TextSpan(
                  text: 'que será enviado no número cadastrado.',
                  style: kTextStyleGuardianBodyTextStyle,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: RichText(
            text: const TextSpan(
              text:
                  '• Lembre-se de conversar com a pessoa antes de cadastra-la. É importante que ela esteja',
              style: kTextStyleGuardianBodyTextStyle,
              children: <TextSpan>[
                TextSpan(
                  text: ' ciente que receberá seus pedidos de socorro ',
                  style: kTextStyleGuardianBodyTextBoldStyle,
                ),
                TextSpan(
                  text: 'via SMS.',
                  style: kTextStyleGuardianBodyTextStyle,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _addGuardianButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SizedBox(
        height: 40,
        width: 215,
        child: PenhasButton.roundedFilled(
          onPressed: () => controller.addGuardian(),
          child: const Text(
            'Adicionar guardião',
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }

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

  ReactionDisposer _showCreateProgress() {
    return reaction((_) => controller.createState, (PageProgressState status) {
      setState(() {
        _loadState = status;
      });
    });
  }

  ReactionDisposer _showAlert() {
    return reaction((_) => controller.alertState, (GuardianAlertState status) {
      status.when(
        initial: () {},
        alert: (action) => _showSentInvite(action),
      );
    });
  }

  void _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  void _showSentInvite(GuardianAlertMessageAction action) {
    Modular.to.showDialog(
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/svg/help_center/guardians/guardians_sent_invite.svg',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(action.title, style: kTextStyleAlertDialogTitle),
              ),
            ],
          ),
          content: Text(
            action.message!,
            style: kTextStyleAlertDialogDescription,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            PenhasButton.text(
              child: const Text('Fechar'),
              onPressed: () async {
                Navigator.of(context).pop();
                action.onPressed();
              },
            ),
          ],
        );
      },
    );
  }
}
