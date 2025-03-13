import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../../../support_center/presentation/pages/support_center_general_error.dart';
import '../../../domain/states/profile_delete_state.dart';
import 'account_delete_controller.dart';

class AccountDeletePage extends StatefulWidget {
  const AccountDeletePage({super.key, required this.controller});
  final AccountDeleteController controller;

  @override
  AccountDeletePageState createState() => AccountDeletePageState();
}

class AccountDeletePageState extends State<AccountDeletePage>
    with SnackBarHandler {
  bool _isPasswordVisible = false;
  AccountDeleteController get _controller => widget.controller;
  final textController = TextEditingController();
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => _controller.errorMessage, (String? message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller.loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Exclusão de conta'),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (context) => bodyBuilder(_controller.state),
      ),
    );
  }

  @override
  void dispose() {
    for (final d in _disposers!) {
      d();
    }
    super.dispose();
  }

  void _togglePassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
}

extension _PageBuilder on AccountDeletePageState {
  Widget bodyBuilder(ProfileDeleteState state) {
    return state.when(
      initial: () => bodyLoading(),
      loaded: (msg) => bodyLoaded(msg),
      error: (msg) => SupportCenterGeneralError(
        message: msg,
        onPressed: _controller.retry,
      ),
    );
  }

  Widget bodyLoading() {
    return SafeArea(
      child: PageProgressIndicator(
        progressMessage: 'Carregando...',
        progressState: PageProgressState.loading,
        child: Container(color: DesignSystemColors.systemBackgroundColor),
      ),
    );
  }

  Widget bodyLoaded(String bodyMessage) {
    return SafeArea(
      child: PageProgressIndicator(
        progressMessage: 'Processando...',
        progressState: _controller.progressState,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Excluir conta',
                  style: titleTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Html(
                    data: bodyMessage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextField(
                    autocorrect: false,
                    controller: textController,
                    keyboardType: TextInputType.text,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: DesignSystemColors.easterPurple),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: DesignSystemColors.easterPurple),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Digite a senha atual',
                      labelStyle: labelTextStyle,
                      contentPadding: const EdgeInsetsDirectional.only(
                        end: 8.0,
                        start: 8.0,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: DesignSystemColors.easterPurple,
                        ),
                        onPressed: _togglePassword,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 250,
                      child: PenhasButton.roundedFilled(
                        onPressed: () =>
                            _controller.delete(textController.text),
                        child: Text('Excluir conta', style: buttonTextStyle),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension _TextStyle on AccountDeletePageState {
  TextStyle get titleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 20.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );

  TextStyle get labelTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        color: DesignSystemColors.easterPurple,
        fontWeight: FontWeight.normal,
      );

  TextStyle get buttonTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.white,
        letterSpacing: 0.45,
      );
}
