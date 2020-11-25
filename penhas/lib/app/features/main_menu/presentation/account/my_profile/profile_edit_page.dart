import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/main_menu/domain/states/profile_edit_state.dart';
import 'package:penhas/app/features/main_menu/presentation/account/my_profile/profile_edit_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_bio_page.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_name_page.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState
    extends ModularState<ProfileEditPage, ProfileEditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Meu perfil"),
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(
        builder: (context) => bodyBuilder(controller.state),
      ),
    );
  }
}

extension _PageBuilder on _ProfileEditPageState {
  Widget bodyBuilder(ProfileEditState state) {
    return state.when(
      initial: () => bodyLoading(),
      loaded: (profile) => bodyLoaded(profile),
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

  Widget bodyLoaded(UserProfileEntity profile) {
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
                onEditAction: () async => askSingleInput(
                  title: 'Editar',
                  hintText: 'Digite o novo nome',
                  onChange: controller.editNickName,
                ),
              ),
              CardProfileBioPage(
                content: profile.minibio ?? "",
                onEditAction: () => askMultilineInput(
                    title: "Editar",
                    hintText: "Informe uma minibio",
                    onChange: controller.editMinibio),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension _Modal on _ProfileEditPageState {
  void askSingleInput({
    @required String title,
    @required String hintText,
    @required void Function(String) onChange,
  }) {
    TextEditingController _controller = TextEditingController();

    Modular.to.showDialog(
      child: AlertDialog(
        title: Text(title),
        content: TextFormField(
          controller: _controller,
          maxLines: 1,
          decoration: InputDecoration(hintText: hintText, filled: true),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Enviar'),
            onPressed: () async {
              onChange(_controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void askMultilineInput({
    @required String title,
    @required String hintText,
    @required void Function(String) onChange,
  }) {
    TextEditingController _controller = TextEditingController();

    Modular.to.showDialog(
      child: AlertDialog(
        title: Text(title),
        content: TextFormField(
          controller: _controller,
          maxLines: 5,
          maxLength: 2200,
          maxLengthEnforced: true,
          decoration: InputDecoration(hintText: hintText, filled: true),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Enviar'),
            onPressed: () async {
              onChange(_controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

extension _ProfileEditPage on _ProfileEditPageState {
  Widget profileHeader() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dados do Perfil", style: profileHeaderTitleTextStyle),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text("Informações exibidas para as usuários do PenhaS.",
                  style: profileHeaderContentTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}

extension _TextStyle on _ProfileEditPageState {
  TextStyle get profileHeaderTitleTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 20.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
  TextStyle get profileHeaderContentTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}
