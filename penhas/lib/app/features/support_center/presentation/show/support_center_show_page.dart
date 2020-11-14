import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_show_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'support_center_show_controller.dart';

class SupportCenterShowPage extends StatefulWidget {
  const SupportCenterShowPage({Key key}) : super(key: key);

  @override
  _SupportCenterShowPageState createState() => _SupportCenterShowPageState();
}

class _SupportCenterShowPageState
    extends ModularState<SupportCenterShowPage, SupportCenterShowController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhe do Ponto"),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(builder: (_) {
        return bodyBuilder(controller.state);
      }),
    );
  }
}

extension _PageStateBuilder on _SupportCenterShowPageState {
  Widget bodyBuilder(SupportCenterShowState state) {
    return state.when(
      initial: () => buildInitialState(),
      loaded: (detail) => buildMainScreen(detail),
      error: (msg) => Container(color: Colors.pinkAccent),
    );
  }

  Widget buildInitialState() {
    return SafeArea(
      child: PageProgressIndicator(
        progressState: PageProgressState.loading,
        progressMessage: "Carregando...",
        child: Container(color: DesignSystemColors.white),
      ),
    );
  }

  Widget buildMainScreen(SupportCenterPlaceDetailEntity detail) {
    return Container(
      color: Colors.greenAccent,
    );
  }
}
