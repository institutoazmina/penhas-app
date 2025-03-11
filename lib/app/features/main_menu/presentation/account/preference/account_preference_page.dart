import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/text_styles.dart';
import '../../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../../../support_center/presentation/pages/support_center_general_error.dart';
import '../../../domain/entities/account_preference_entity.dart';
import '../../../domain/states/account_preference_state.dart';
import 'account_preference_controller.dart';

class AccountPreferencePage extends StatefulWidget {
  const AccountPreferencePage({Key? key, required this.controller})
      : super(key: key);

  final AccountPreferenceController controller;

  @override
  AccountPreferencePageState createState() => AccountPreferencePageState();
}

class AccountPreferencePageState extends State<AccountPreferencePage>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AccountPreferenceController get controller => widget.controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.messageError, (String? message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: DesignSystemColors.white,
          ),
          onPressed: Modular.to.pop,
        ),
        centerTitle: true,
        title: const Text('Configurações'),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (context) => bodyBuilder(controller.state),
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

extension _PageBuilder on AccountPreferencePageState {
  Widget bodyBuilder(AccountPreferenceState state) {
    return state.when(
      initial: () => bodyLoading(),
      loaded: (preferences) => bodyLoaded(preferences),
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

  Widget bodyLoaded(List<AccountPreferenceEntity> preferences) {
    return SafeArea(
      child: PageProgressIndicator(
        progressMessage: 'Atualizando...',
        progressState: controller.progress,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Marque abaixo quais notificações deseja receber',
                  style: kTextStyleAlertDialogTitle,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: preferences.length,
                  itemBuilder: (BuildContext context, int index) {
                    final preference = preferences[index];
                    return CheckboxListTile(
                      title: Text(preference.label!, style: itemTitleTextStyle),
                      value: preference.value,
                      activeColor: DesignSystemColors.easterPurple,
                      onChanged: (status) => controller.update(
                        preference.key,
                        status: status == true,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension _TextStyle on AccountPreferencePageState {
  TextStyle get itemTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
}
