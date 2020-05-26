import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'sign_up_controller.dart';

import 'package:intl/intl.dart';

class SignUpPage extends StatefulWidget {
  final String title;
  const SignUpPage({Key key, this.title = "SignUp"}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  PageProgressState _currentState = PageProgressState.initial;

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
    return SizedBox.expand(
      child: Container(
        decoration: kLinearGradientDesignSystem,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: PageProgressIndicator(
            progressState: _currentState,
            child: GestureDetector(
              onTap: () => _handleTap(context),
              onPanDown: (_) => _handleTap(context),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(),
                      SizedBox(height: 18.0),
                      _buildSubHeader(),
                      SizedBox(height: 22.0),
                      Observer(builder: (_) => _buildFullName()),
                      SizedBox(height: 24.0),
                      Observer(builder: (_) {
                        return _buildDateTimeField(
                          onChanged: controller.setBirthday,
                          onError: controller.warningBirthday,
                        );
                      }),
                      SizedBox(height: 24.0),
                      Observer(builder: (_) {
                        return _buildCpf();
                      }),
                      SizedBox(height: 24.0),
                      Observer(builder: (_) {
                        return _buildCep();
                      }),
                      SizedBox(height: 24.0),
                      SizedBox(height: 40.0, child: _buildNextButton()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SingleTextInput _buildCep() {
    return SingleTextInput(
      labelText: 'CEP',
      hintText: 'CEP',
      keyboardType: TextInputType.number,
      onChanged: controller.setCep,
      errorText: controller.warningCep,
      inputFormatter: _maskCep,
    );
  }

  SingleTextInput _buildCpf() {
    return SingleTextInput(
      labelText: 'CPF',
      hintText: 'CPF',
      keyboardType: TextInputType.number,
      onChanged: controller.setCpf,
      errorText: controller.warningCpf,
      inputFormatter: _maskCpf,
    );
  }

  SingleTextInput _buildFullName() {
    return SingleTextInput(
        labelText: 'Nome completo',
        errorText: controller.warningFullname,
        onChanged: controller.setFullname);
  }

  SizedBox _buildSubHeader() {
    return SizedBox(
      height: 60.0,
      child: Text(
        'Para sua segurança pedimos aos nossos usuários o CPF.',
        style: kRegisterSubHeaderLabelStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _buildHeader() {
    return Text(
      'Crie sua conta',
      style: kRegisterHeaderLabelStyle,
      textAlign: TextAlign.center,
    );
  }

  _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

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
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.currentState, (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }
}
