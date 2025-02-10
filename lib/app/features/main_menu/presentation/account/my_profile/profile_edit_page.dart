import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../appstate/domain/entities/user_profile_entity.dart';
import '../../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../../../support_center/presentation/pages/support_center_general_error.dart';
import '../../../domain/states/profile_edit_state.dart';
import '../pages/card_profile_bio_page.dart';
import '../pages/card_profile_email_page.dart';
import '../pages/card_profile_name_page.dart';
import '../pages/card_profile_password_page.dart';
import '../pages/card_profile_race_page.dart';
import '../pages/card_profile_single_tile_page.dart';
import '../pages/card_profile_skill_page.dart';
import 'profile_edit_controller.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key, required this.controller}) : super(key: key);

  final ProfileEditController controller;

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileEditController get _controller => widget.controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => _controller.updateError, (String? message) {
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
        title: const Text('Meu perfil'),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (context) => bodyBuilder(_controller.state),
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

extension _PageBuilder on _ProfileEditPageState {
  Widget bodyBuilder(ProfileEditState state) {
    return state.when(
      initial: () => bodyLoading(),
      loaded: (profile, securityModeFeatureEnabled) => bodyLoaded(
        profile,
        securityModeFeatureEnabled: securityModeFeatureEnabled,
      ),
      error: (msg) => SupportCenterGeneralError(
        message: msg,
        onPressed: _controller.retry,
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

  Widget bodyLoaded(
    UserProfileEntity profile, {
    required bool securityModeFeatureEnabled,
  }) {
    return SafeArea(
      child: PageProgressIndicator(
        progressMessage: 'Atualizando...',
        progressState: _controller.progressState,
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileHeader(),
              CardProfileNamePage(
                name: profile.nickname,
                avatar: profile.avatar,
                onChange: _controller.editNickName,
              ),
              if (securityModeFeatureEnabled)
                CardProfileBioPage(
                  content: profile.minibio ?? '',
                  onChange: _controller.editMinibio,
                ),
              if (securityModeFeatureEnabled)
                CardProfileSkillPage(
                  skills: _controller.profileSkill,
                  onEditAction: _controller.editSkill,
                ),
              if (securityModeFeatureEnabled)
                CardProfileSingleTilePage(
                  title: 'Já foi vítima de violência contra a mulher?',
                  content: profile.jaFoiVitimaDeViolencia ? 'Sim' : 'Não',
                ),
              const CardProfileSingleTilePage(
                title: 'Cadastro',
                content:
                    'Informações privadas que nenhuma outra usuária terá acesso.',
                background: DesignSystemColors.systemBackgroundColor,
              ),
              CardProfileSingleTilePage(
                title: 'Data de Nascimento',
                content:
                    '${profile.birthdate.day}/${profile.birthdate.month}/${profile.birthdate.year}',
                background: DesignSystemColors.systemBackgroundColor,
              ),
              CardProfileRacePage(
                content: profile.race,
                onChange: _controller.updateRace,
              ),
              CardProfileSingleTilePage(
                title: 'Sexo',
                content: profile.genre,
                background: DesignSystemColors.systemBackgroundColor,
              ),
              CardProfileEmailPage(
                content: profile.email,
                onChange: _controller.updatedEmail,
              ),
              CardProfilePasswordPage(
                content: '************',
                onChange: _controller.updatePassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension _Modal on _ProfileEditPageState {}

extension _ProfileEditPage on _ProfileEditPageState {
  Widget profileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dados do Perfil', style: profileHeaderTitleTextStyle),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Informações exibidas para as usuárias do PenhaS.',
              style: profileHeaderContentTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

extension _TextStyle on _ProfileEditPageState {
  TextStyle get profileHeaderTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 20.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );

  TextStyle get profileHeaderContentTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}
