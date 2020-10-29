import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';

import 'pages/support_center_input_filter.dart';
import 'support_center_controller.dart';

class SupportCenterPage extends StatefulWidget {
  SupportCenterPage({Key key}) : super(key: key);

  @override
  _SupportCenterPageState createState() => _SupportCenterPageState();
}

class _SupportCenterPageState
    extends ModularState<SupportCenterPage, SupportCenterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) {
            return PageProgressIndicator(
              progressState: controller.progressState,
              child: Column(
                children: [
                  SupportCenterInputFilter(
                    totalOfFilter: controller.categoriesSelected,
                    onFilterAction: controller.onFilterAction,
                    onKeywordsAction: controller.onKeywordsAction,
                  ),
                  Container(
                    height: 80,
                    color: Colors.yellowAccent,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
