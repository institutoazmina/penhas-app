import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
  const ProfileEditPage({super.key, required this.controller});

  final ProfileEditController controller;

  @override
  ProfileEditPageState createState() => ProfileEditPageState();
}

class ProfileEditPageState extends State<ProfileEditPage> with SnackBarHandler {
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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Modular.to.pop,
        ),
        title: const Text('Meu perfil'),
        backgroundColor: DesignSystemColors.easterPurple,
        foregroundColor: DesignSystemColors.white,
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

extension _PageBuilder on ProfileEditPageState {
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
              profileHeader(
                  title: 'Dados do Perfil',
                  subtitle: 'Informações exibidas para as usuárias do PenhaS.'),
              CardProfileNamePage(
                name: profile.nickname,
                avatar: profile.avatar,
                badges: profile.badges,
                onChange: _controller.editNickName,
              ),
              _divider(),
              if (securityModeFeatureEnabled)
                CardProfileBioPage(
                  content: profile.minibio ?? '',
                  onChange: _controller.editMinibio,
                ),
              _divider(),
              if (securityModeFeatureEnabled)
                CardProfileSkillPage(
                  skills: _controller.profileSkill,
                  onEditAction: _controller.editSkill,
                ),
              _divider(),
              if (securityModeFeatureEnabled)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CardProfileSingleTilePage(
                    title: 'Já foi vítima de violência contra a mulher?',
                    content: profile.jaFoiVitimaDeViolencia ? 'Sim' : 'Não',
                  ),
                ),
              profileHeader(
                title: 'Cadastro',
                subtitle:
                    'Informações privadas que nenhuma outra usuária terá acesso.',
              ),
              CardProfileSingleTilePage(
                title: 'Data de Nascimento',
                content:
                    '${profile.birthdate.day}/${profile.birthdate.month}/${profile.birthdate.year}',
                background: DesignSystemColors.systemBackgroundColor,
              ),
              _divider(),
              CardProfileRacePage(
                content: profile.race,
                onChange: _controller.updateRace,
              ),
              _divider(),
              CardProfileSingleTilePage(
                title: 'Sexo',
                content: profile.genre,
                background: DesignSystemColors.systemBackgroundColor,
              ),
              _divider(),
              CardProfileEmailPage(
                content: profile.email,
                onChange: _controller.updatedEmail,
              ),
              _divider(),
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

Widget _divider() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Divider(
      color: DesignSystemColors.pinkishGrey,
      thickness: 1,
    ),
  );
}

extension _Modal on ProfileEditPageState {}

extension _ProfileEditPage on ProfileEditPageState {
  Widget profileHeader({required String title, required String subtitle}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: DesignSystemColors.helpCenterBackGround,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16.0, top: 25, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: profileHeaderTitleTextStyle),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                subtitle,
                style: profileHeaderContentTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension _TextStyle on ProfileEditPageState {
  TextStyle get profileHeaderTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 20.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get profileHeaderContentTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.white,
        fontWeight: FontWeight.normal,
      );
}
