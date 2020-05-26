import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/linear_gradient_design_system.dart';
import 'sign_up_controller.dart';

import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  final String title;
  const SignUpPage({Key key, this.title = "SignUp"}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController> {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey navigator = GlobalKey<NavigatorState>();

  final format = DateFormat("dd/MM/yyyy");

  final _maskCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _maskCep = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showErrorMessage(),
      _showProgress(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _disposers.forEach((d) => d());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (currentFocus != null && !currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Criar conta'),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: SizedBox.expand(
          child: Container(
            decoration: kLinearGradientDesignSystem,
            child: SafeArea(
                child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 78.0,
                    child: Text(
                      'Para sua segurança pedimos aos nossos usuários o CPF.',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 22.0),
                  Observer(builder: (_) {
                    return _buildInputField(
                      labelText: 'Nome completo',
                      keyboardType: TextInputType.text,
                      onChanged: controller.setFullname,
                      onError: controller.warningFullname,
                    );
                  }),
                  SizedBox(height: 24.0),
                  Observer(builder: (_) {
                    return _buildDateTimeField(
                      onChanged: controller.setBirthday,
                      onError: controller.warningBirthday,
                    );
                  }),
                  SizedBox(height: 24.0),
                  Observer(builder: (_) {
                    return _buildInputField(
                      labelText: 'CPF',
                      hintText: 'CPF',
                      keyboardType: TextInputType.number,
                      onChanged: controller.setCpf,
                      onError: controller.warningCpf,
                      inputFormatter: _maskCpf,
                    );
                  }),
                  SizedBox(height: 24.0),
                  Observer(builder: (_) {
                    return _buildInputField(
                      labelText: 'CEP',
                      hintText: 'CEP',
                      keyboardType: TextInputType.number,
                      onChanged: controller.setCep,
                      onError: controller.warningCep,
                      inputFormatter: _maskCep,
                    );
                  }),
                  SizedBox(height: 24.0),
                  SizedBox(height: 40.0, child: _buildNextButton()),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  // _handleTap(BuildContext context) {
  //   //To improve user experience, we'll unfocus any textfields when the users taps oon the background of the form
  //   if (MediaQuery.of(context).viewInsets.bottom > 0) SystemChannels.textInput.invokeMethod('TextInput.hide');
  //   WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  // }

  DateTimeField _buildDateTimeField({
    Function(DateTime) onChanged,
    String onError,
  }) {
    return DateTimeField(
      format: format,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        labelText: 'Data de nascimento',
        labelStyle: TextStyle(color: Colors.white),
        errorText: (onError?.isEmpty ?? true) ? null : onError,
        border: OutlineInputBorder(),
        contentPadding:
            EdgeInsetsDirectional.only(end: 8.0, start: 8.0, bottom: 8.0),
      ),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
      onChanged: onChanged,
    );
  }

  TextFormField _buildInputField({
    String labelText,
    String hintText,
    TextInputType keyboardType,
    Function(String) onChanged,
    String onError,
    TextInputFormatter inputFormatter,
  }) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter == null ? null : [inputFormatter],
      autocorrect: false,
      textInputAction: TextInputAction.done,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        errorText: (onError?.isEmpty ?? true) ? null : onError,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
      ),
    );
  }

  RaisedButton _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.nextStepPressed(),
      elevation: 0,
      color: DesignSystemColors.ligthPurple,
      child: Text(
        "Próximo",
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
      if (message.isNotEmpty) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.currentState, (StoreState state) {
      switch (state) {
        case StoreState.initial:
          break;
        case StoreState.loading:
          _onLoading();
          break;
        case StoreState.loaded:
          Navigator.of(navigator.currentContext, rootNavigator: true).pop();

          break;
      }
    });
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 80,
            width: 100,
            child: Row(
              children: [
                SizedBox(width: 18),
                CircularProgressIndicator(),
                SizedBox(width: 18),
                Text("Processando"),
              ],
            ),
          ),
        );
      },
    );
  }
}
