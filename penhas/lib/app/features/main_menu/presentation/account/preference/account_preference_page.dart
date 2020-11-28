import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/main_menu/domain/states/account_preference_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'account_preference_controller.dart';

class AccountPreferencePage extends StatefulWidget {
  const AccountPreferencePage({Key key}) : super(key: key);

  @override
  _AccountPreferencePageState createState() => _AccountPreferencePageState();
}

class _AccountPreferencePageState
    extends ModularState<AccountPreferencePage, AccountPreferenceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Preferência da conta"),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (context) => bodyBuilder(controller.state),
      ),
    );
  }
}

extension _PageBuilder on _AccountPreferencePageState {
  Widget bodyBuilder(AccountPreferenceState state) {
    return state.when(
      initial: () => bodyLoading(),
      // loaded: (profile) => bodyLoaded(profile),
      // error: (msg) => SupportCenterGeneralError(
      //   message: msg,
      //   onPressed: controller.retry,
      // ),
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
}
