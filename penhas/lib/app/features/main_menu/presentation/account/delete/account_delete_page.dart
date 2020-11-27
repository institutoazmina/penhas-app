import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/main_menu/domain/states/profile_delete_state.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'account_delete_controller.dart';

class AccountDeletePage extends StatefulWidget {
  const AccountDeletePage({Key key}) : super(key: key);

  @override
  _AccountDeletePageState createState() => _AccountDeletePageState();
}

class _AccountDeletePageState
    extends ModularState<AccountDeletePage, AccountDeleteController> {
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
}

extension _PageBuilder on _AccountDeletePageState {
  Widget bodyBuilder(ProfileDeleteState state) {
    return state.when(
      initial: () => bodyLoading(),
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
}
