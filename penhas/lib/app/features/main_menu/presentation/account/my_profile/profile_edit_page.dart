import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/main_menu/domain/states/profile_edit_state.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/profile_edit_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_bio_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_email_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_name_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_password_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_race_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_single_tile_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_skill_page.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState
    extends ModularState<ProfileEditPage, ProfileEditController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.updateError, (String? message) {
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
        builder: (context) => bodyBuilder(controller.state),
      ),
    );
  }

  @override
  void dispose() {
    for (var d in _disposers!) {
      d();
    }
    super.dispose();
  }
}

extension _PageBuilder on _ProfileEditPageState {
  Widget bodyBuilder(ProfileEditState state) {
    return state.when(
      initial: () => bodyLoading(),
      loaded: (profile, securityModeFeatureEnabled) =>
          bodyLoaded(profile, securityModeFeatureEnabled),
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

  Widget bodyLoaded(
      UserProfileEntity profile, bool securityModeFeatureEnabled) {
    return SafeArea(
      child: PageProgressIndicator(
        progressMessage: 'Atualizando...',
        progressState: controller.progressState,
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileHeader(),
              CardProfileNamePage(
                name: profile.nickname,
                avatar: profile.avatar,
                onChange: controller.editNickName,
              ),
              if (securityModeFeatureEnabled)
                CardProfileBioPage(
                  content: profile.minibio ?? '',
                  onChange: controller.editMinibio,
                ),
              if (securityModeFeatureEnabled)
                CardProfileSkillPage(
                  skills: controller.profileSkill,
                  onEditAction: controller.editSkill,
                ),
              if (securityModeFeatureEnabled)
                CardProfileSingleTilePage(
                  title: 'Já foi vítima de violência contra a mulher?',
                  content: profile.jaFoiVitimaDeViolencia? 'Sim' : 'Não',
                ),
              const CardProfileSingleTilePage(
                title: 'Cadastro',
                content:
                    'Informações privadas que nenhuma outra usuária terá acesso.',
                background: DesignSystemColors.systemBackgroundColor,
              ),
              CardProfileSingleTilePage(
                title: 'Data de Nascimento',
                content: "${profile.birthdate.day}/${profile.birthdate.month}/${profile.birthdate.year}",
                background: DesignSystemColors.systemBackgroundColor,
              ),
              CardProfileRacePage(
                content: profile.race,
                onChange: controller.updateRace,
              ),
              CardProfileSingleTilePage(
                title: 'Sexo',
                content: profile.genre,
                background: DesignSystemColors.systemBackgroundColor,
              ),
              CardProfileEmailPage(
                content: profile.email,
                onChange: controller.updatedEmail,
              ),
              CardProfilePasswordPage(
                content: '************',
                onChange: controller.updatePassword,
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dados do Perfil', style: profileHeaderTitleTextStyle),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text('Informações exibidas para as usuários do PenhaS.',
                  style: profileHeaderContentTextStyle,),
            ),
          ],
        ),
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
