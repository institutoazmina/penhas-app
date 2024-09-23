import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/button_shape.dart';
import '../../../../shared/design_system/buttons/styles.dart';
import '../../../../shared/design_system/colors.dart';
import '../shared/page_progress_indicator.dart';
import '../shared/snack_bar_handler.dart';
import 'deleted_account_controller.dart';

class DeletedAccountPage extends StatefulWidget {
  const DeletedAccountPage({Key? key}) : super(key: key);

  @override
  _DeletedAccountPageState createState() => _DeletedAccountPageState();
}

class _DeletedAccountPageState
    extends ModularState<DeletedAccountPage, DeletedAccountController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String? message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Conta excluída'),
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
    for (final d in _disposers!) {
      d();
    }
    super.dispose();
  }
}

extension _TextStyle on _DeletedAccountPageState {
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
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );

  TextStyle get activeButtonTextStyle => const TextStyle(
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
                  'Esta conta está marcada para ser excluída.\n\nVocê pode interromper este processo agora reativando a conta.',
                  style: labelTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60.0),
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 250,
                    child: FilledButton(
                      onPressed: () => controller.reactive(),
                      style: FilledButtonStyle.raised(
                        elevation: 0,
                        color: DesignSystemColors.ligthPurple,
                        shape: kButtonShapeOutlinePurple,
                      ),
                      child:
                          Text('Reativar Conta', style: activeButtonTextStyle),
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
