import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'deleted_account_controller.dart';

class DeletedAccountPage extends StatefulWidget {
  DeletedAccountPage({Key key}) : super(key: key);

  @override
  _DeletedAccountPageState createState() => _DeletedAccountPageState();
}

class _DeletedAccountPageState
    extends ModularState<DeletedAccountPage, DeletedAccountController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Conta excluída"),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (context) => bodyBuilder(),
      ),
    );
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }
}

extension _TextStyle on _DeletedAccountPageState {
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
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );

  TextStyle get activeButtonTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.white,
        letterSpacing: 0.45,
      );
}

extension _MethodPrivate on _DeletedAccountPageState {
  Widget bodyBuilder() {
    return SafeArea(
      child: PageProgressIndicator(
        progressState: controller.progressState,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deseja reativar?',
                style: titleTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  "Esta conta está marcada para ser excluída.\n\nVocê pode intererromper este processo agora reativando a conta.",
                  style: labelTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 60.0),
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 250,
                    child: RaisedButton(
                      onPressed: () => controller.reactive(),
                      elevation: 0,
                      color: DesignSystemColors.ligthPurple,
                      child:
                          Text("Reativar Conta", style: activeButtonTextStyle),
                      shape: kButtonShapeOutlinePurple,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
