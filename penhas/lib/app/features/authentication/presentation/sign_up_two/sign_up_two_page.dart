import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/widget.dart';
import 'sign_up_two_controller.dart';

class SignUpTwoPage extends StatefulWidget {
  final String title;
  const SignUpTwoPage({Key key, this.title = "SignUpTwo"}) : super(key: key);

  @override
  _SignUpTwoPageState createState() => _SignUpTwoPageState();
}

class _SignUpTwoPageState
    extends ModularState<SignUpTwoPage, SignUpTwoController> {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final dataSourceGenre =
      _buildDataSource(SignUpTwoController.genreDataSource());
  final dataSourceRace = _buildDataSource(SignUpTwoController.raceDataSource());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showErrorMessage(),
      // _showProgress(),
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
        extendBodyBehindAppBar: true,
        body: SizedBox.expand(
          child: Container(
            decoration: DesignSystemWidget.background(),
            child: SafeArea(
                child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 48.0,
                    child: Text(
                      'Nos conte um pouco mais sobre você',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white60,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 48.0),
                  Observer(builder: (_) {
                    return _buildInputField(
                      labelText: 'Apelido',
                      keyboardType: TextInputType.text,
                      onChanged: controller.setNickname,
                      onError: controller.warningNickname,
                    );
                  }),
                  SizedBox(height: 24.0),
                  Observer(builder: (_) {
                    return _buildDropdownList(
                      context: context,
                      labelText: 'Gênero',
                      onError: controller.warningGenre,
                      onChange: controller.setGenre,
                      currentValue: controller.currentGenre,
                      dataSource: dataSourceGenre,
                    );
                  }),
                  SizedBox(height: 24.0),
                  Observer(builder: (_) {
                    return _buildDropdownList(
                      context: context,
                      labelText: 'Raça',
                      onError: controller.warningRace,
                      onChange: controller.setRace,
                      currentValue: controller.currentRace,
                      dataSource: dataSourceRace,
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

  Widget _buildDropdownList<T>({
    @required BuildContext context,
    @required String labelText,
    @required String onError,
    @required onChange,
    @required T currentValue,
    @required List dataSource,
  }) {
    return Theme(
      data: Theme.of(context)
          .copyWith(canvasColor: Color.fromRGBO(141, 146, 157, 1)),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          errorText: (onError?.isEmpty ?? true) ? null : onError,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        ),
        items: dataSource,
        onChanged: onChange,
        style: TextStyle(color: Colors.white),
        value: currentValue == '' ? null : currentValue,
      ),
    );
  }

  TextFormField _buildInputField({
    String labelText,
    String hintText,
    TextInputType keyboardType,
    Function(String) onChanged,
    String onError,
  }) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
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

  static List<DropdownMenuItem<String>> _buildDataSource(
      List<MenuItemModel> list) {
    return list
        .map(
          (v) => DropdownMenuItem<String>(
            child: Text(v.display),
            value: v.value,
          ),
        )
        .toList();
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
}
