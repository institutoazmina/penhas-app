import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/main_menu/domain/states/profile_delete_state.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'account_delete_controller.dart';

class AccountDeletePage extends StatefulWidget {
  const AccountDeletePage({Key key}) : super(key: key);

  @override
  _AccountDeletePageState createState() => _AccountDeletePageState();
}

class _AccountDeletePageState
    extends ModularState<AccountDeletePage, AccountDeleteController>
    with SnackBarHandler {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Exclusão de conta"),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (context) => bodyBuilder(controller.state),
      ),
    );
  }

  void _togglePassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
}

extension _PageBuilder on _AccountDeletePageState {
  Widget bodyBuilder(ProfileDeleteState state) {
    return state.when(
      initial: () => bodyLoading(),
      loaded: (msg) => bodyLoaded(msg),
      error: (msg) => SupportCenterGeneralError(
        message: msg,
        onPressed: controller.retry,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20.0,
        ),
        child: PageProgressIndicator(
          progressMessage: "Processando...",
          progressState: controller.progressState,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Excluir conta",
                  style: titleTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: HtmlWidget(
                    bodyMessage,
                    webViewJs: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: DesignSystemColors.easterPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: DesignSystemColors.easterPurple),
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Digite a senha atual",
                      labelStyle: labelTextStyle,
                      contentPadding:
                          EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: DesignSystemColors.easterPurple),
                        onPressed: _togglePassword,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 250,
                      child: RaisedButton(
                        onPressed: () => print("Ola mundo!"),
                        elevation: 0,
                        color: DesignSystemColors.ligthPurple,
                        child: Text("Excluir conta", style: buttonTextStyle),
                        shape: kButtonShapeOutlinePurple,
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

extension _TextStyle on _AccountDeletePageState {
  TextStyle get titleTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 20.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );

  TextStyle get labelTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        color: DesignSystemColors.easterPurple,
        fontWeight: FontWeight.normal,
      );

  TextStyle get buttonTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.white,
        letterSpacing: 0.45,
      );
}
