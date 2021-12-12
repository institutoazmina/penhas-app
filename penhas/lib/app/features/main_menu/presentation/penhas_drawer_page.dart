import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/core/pages/tutorial_scale_route.dart';
import 'package:penhas/app/core/states/security_toggle_state.dart';
import 'package:penhas/app/features/main_menu/presentation/pages/penhas_drawer_header_page.dart';
import 'package:penhas/app/features/main_menu/presentation/pages/penhas_drawer_toogle_page.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_controller.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class PenhasDrawerPage extends StatefulWidget {
  final String title;
  const PenhasDrawerPage({required Key key, this.title = "Penhas Drawer"})
      : super(key: key);

  final String title;

  @override
  _PenhasDrawerPageState createState() => _PenhasDrawerPageState();
}

class _PenhasDrawerPageState
    extends ModularState<PenhasDrawerPage, PenhasDrawerController> {
  final double listHeight = 80;
  final Color drawerGrey = const Color.fromRGBO(239, 239, 239, 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(
            width: MediaQuery.of(context).size.width - 60,
          ),
          color: Colors.white,
          child: Observer(
            builder: (_) {
              return ListView(
                children: <Widget>[
                  PenhasDrawerHeaderPage(
                    userName: controller.userName,
                    userAvatar: _buildAvatar(controller.userAvatar),
                  ),
                  _buildSecurityToggle(
                    controller.showSecurityOptions,
                    controller.anonymousModeState,
                  ),
                  _buildSecurityToggle(
                    controller.showSecurityOptions,
                    controller.stealthModeState,
                  ),
                  _buildStealthModeNotice(controller.showSecurityOptions),
                  _buildItemList(
                    title: 'Informações pessoais',
                    icon: SvgPicture.asset(
                      'assets/images/svg/drawer/user_profile.svg',
                      color: DesignSystemColors.darkIndigoThree,
                    ),
                    onPressed: () {
                      Modular.to.pushNamed('/mainboard/menu/profile_edit');
                    },
                  ),
                  _buildItemList(
                    title: 'Configurações',
                    icon: SvgPicture.asset(
                      'assets/images/svg/drawer/account_setting.svg',
                      color: DesignSystemColors.darkIndigoThree,
                    ),
                    onPressed: () {
                      Modular.to
                          .pushNamed('/mainboard/menu/account_preference');
                    },
                  ),
                  _buildItemList(
                    title: 'Exclusão da conta',
                    icon: SvgPicture.asset(
                      'assets/images/svg/drawer/trash.svg',
                      color: DesignSystemColors.darkIndigoThree,
                    ),
                    onPressed: () {
                      Modular.to.pushNamed('/mainboard/menu/account_delete');
                    },
                  ),
                  _buildItemList(
                    title: 'Sobre o PenhaS',
                    icon: SvgPicture.asset(
                      'assets/images/svg/drawer/menu_penhas_icone.svg',
                      color: DesignSystemColors.darkIndigoThree,
                    ),
                    onPressed: () {
                      Modular.to.pushNamed('/mainboard/menu/about');
                    },
                  ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 126.0),
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      onPressed: () => controller.logoutPressed(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.power_settings_new,
                            size: 40,
                            color: DesignSystemColors.ligthPurple,
                          ),
                          SizedBox(width: 12),
                          Text('Sair', style: kTextStyleDrawerLogoutLabel),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Container _buildStealthModeNotice(bool isVisible) {
    return !isVisible
        ? Container()
        : Container(
            margin: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                Text(
                  'Indique que está em situação de violência para ficar anônima, e utilize o Modo camuflado para aplicar um disfarce de app de signo para esconder o verdadeiro conteúdo do PenhaS.',
                  style: securityContextTextStyle,
                ),
                FlatButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      TutorialScaleRoute(page: const StealthModeTutorialPage()),
                    );
                  },
                  child: Text(
                    'Como funciona',
                    style: securityTutorialButtonTextStyle,
                  ),
                )
              ],
            ),
          );
  }

  Widget _buildAvatar(String avatarPath) {
    if (avatarPath.isEmpty) {
      return Container();
    }

    return SvgPicture.network(
      avatarPath,
      color: DesignSystemColors.darkIndigo,
      height: 36,
    );
  }

  Widget _buildItemList({
    required String title,
    required Widget icon,
    required GestureTapCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 16.0),
        height: listHeight,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: DesignSystemColors.pinkishGrey),
          ),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(height: 26.0, width: 26.0, child: icon),
            const SizedBox(width: 9.0),
            Text(
              title,
              style: kTextStyleDrawerListItem,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityToggle(bool isVisible, SecurityToggleState state) {
    if (!isVisible) return Container();

    return PenhasDrawerTooglePage(state: state);
  }
}

extension _TextStyel on _PenhasDrawerPageState {
  TextStyle get securityContextTextStyle => const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontFamily: 'Lato',
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      );

  TextStyle get securityTutorialButtonTextStyle => const TextStyle(
        color: DesignSystemColors.pinky,
        fontFamily: 'Lato',
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      );
}
