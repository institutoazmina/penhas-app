import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../shared/design_system/colors.dart';
import '../../../../../../../shared/design_system/linear_gradient_design_system.dart';
import '../../../../../../../shared/design_system/text_styles.dart';
import '../../../../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../../shared/input_box_style.dart';
import '../../../../shared/page_progress_indicator.dart';
import '../../../../shared/single_text_input.dart';
import '../../../../shared/snack_bar_handler.dart';
import 'sign_up_two_controller.dart';

class SignUpTwoPage extends StatefulWidget {
  const SignUpTwoPage(
      {super.key, this.title = 'SignUpTwo', required this.controller});

  final String title;
  final SignUpTwoController controller;

  @override
  State<SignUpTwoPage> createState() => _SignUpTwoPageState();
}

class _SignUpTwoPageState extends State<SignUpTwoPage> with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;
  SignUpTwoController get _controller => widget.controller;

  final dataSourceGenre =
      _buildDataSource(SignUpTwoController.genreDataSource());
  final dataSourceRace = _buildDataSource(SignUpTwoController.raceDataSource());

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
    for (final d in _disposers!) {
      d();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: kLinearGradientDesignSystem,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            foregroundColor: DesignSystemColors.white,
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
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(),
                      const SizedBox(height: 18.0),
                      _buildSubHeader(),
                      const SizedBox(height: 22.0),
                      Observer(builder: (_) => _buildNickName()),
                      Observer(builder: (_) => _buildSocialName()),
                      const SizedBox(height: 24.0),
                      Observer(
                        builder: (_) {
                          return _buildDropdownList(
                            context: context,
                            labelText: 'Gênero',
                            keyIdentification: const Key('genreDropdownList'),
                            onError: _controller.warningGenre,
                            onChange: _controller.setGenre,
                            currentValue: _controller.currentGenre,
                            dataSource: dataSourceGenre,
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      Observer(
                        builder: (_) {
                          return _buildDropdownList(
                            context: context,
                            labelText: 'Raça',
                            keyIdentification: const Key('raceDropdownList'),
                            onError: _controller.warningRace,
                            onChange: _controller.setRace,
                            currentValue: _controller.currentRace,
                            dataSource: dataSourceRace,
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
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

  SingleTextInput _buildNickName() {
    return SingleTextInput(
      onChanged: _controller.setNickname,
      boxDecoration: WhiteBoxDecorationStyle(
        labelText: 'Apelido',
        errorText: _controller.warningNickname,
      ),
    );
  }

  Offstage _buildSocialName() {
    return Offstage(
      offstage: !_controller.hasSocialNameField,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 24.0),
          SingleTextInput(
            onChanged: _controller.setSocialName,
            boxDecoration: WhiteBoxDecorationStyle(
              labelText: 'Nome social',
              errorText: _controller.warningSocialName,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownList<T>({
    required BuildContext context,
    required String labelText,
    required Key keyIdentification,
    required String? onError,
    required onChange,
    required T currentValue,
    required List dataSource,
  }) {
    return Theme(
      data: Theme.of(context)
          .copyWith(canvasColor: const Color.fromRGBO(141, 146, 157, 1)),
      child: DropdownButtonFormField(
        key: keyIdentification,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          errorText: (onError?.isEmpty ?? true) ? null : onError,
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          contentPadding:
              const EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        ),
        items: dataSource as List<DropdownMenuItem<T>>,
        onChanged: onChange,
        style: const TextStyle(color: Colors.white),
        value: currentValue == '' ? null : currentValue,
      ),
    );
  }

  Widget _buildNextButton() {
    return PenhasButton.roundedFilled(
      onPressed: () => _controller.nextStepPressed(),
      child: const Text(
        'Próximo',
        style: kTextStyleDefaultFilledButtonLabel,
      ),
    );
  }

  static List<DropdownMenuItem<String>> _buildDataSource(
    List<MenuItemModel> list,
  ) {
    return list
        .map(
          (v) => DropdownMenuItem<String>(
            value: v.value,
            child: Text(v.display!),
          ),
        )
        .toList();
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => _controller.errorMessage, (String message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => _controller.currentState,
        (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }

  SizedBox _buildSubHeader() {
    return const SizedBox(
      height: 60.0,
      child: Text(
        'Nos conte um pouco mais sobre você.',
        style: kTextStyleRegisterSubHeaderLabelStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _buildHeader() {
    return const Text(
      'Crie sua conta',
      style: kTextStyleRegisterHeaderLabelStyle,
      textAlign: TextAlign.center,
    );
  }

  void _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
