import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/pages/tutorial_scale_route.dart';
import '../../../shared/design_system/colors.dart';
import '../../../shared/design_system/text_styles.dart';
import '../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../quiz/presentation/tutorial/stealth_mode_tutorial_page.dart';
import '../../quiz/presentation/tutorial/stealth_mode_tutorial_page_controller.dart';
import 'pages/penhas_drawer_header_page.dart';
import 'pages/penhas_drawer_toggle_page.dart';
import 'penhas_drawer_controller.dart';

class PenhasDrawerPage extends StatefulWidget {
  const PenhasDrawerPage(
      {super.key,
      this.title = 'Penhas Drawer',
      required this.controller,
      required this.stealthController});

  final String title;
  final PenhasDrawerController controller;
  final StealthModeTutorialPageController stealthController;

  @override
  PenhasDrawerPageState createState() => PenhasDrawerPageState();
}

class _PenhasDrawerPageState extends State<PenhasDrawerPage> {
  final double listHeight = 80;
  final Color drawerGrey = const Color.fromRGBO(239, 239, 239, 1.0);
  PenhasDrawerController get _controller => widget.controller;
  StealthModeTutorialPageController get _stealthController =>
      widget.stealthController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.init();
    });
  }

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
                    userName: _controller.userName,
                    userAvatar: _buildAvatar(_controller.userAvatar),
                  ),
                  if (_controller.showSecurityOptions)
                    PenhasDrawerTogglePage(
                        state: _controller.anonymousModeState),
                  if (_controller.showSecurityOptions)
                    PenhasDrawerTogglePage(state: _controller.stealthModeState),
                  _buildStealthModeNotice(_controller.showSecurityOptions),
                  _buildItemList(
                    title: 'Informações pessoais',
                    icon: SvgPicture.asset(
                      'assets/images/svg/drawer/user_profile.svg',
                      colorFilter: const ColorFilter.mode(
                          DesignSystemColors.darkIndigoThree, BlendMode.srcIn),
                    ),
                    onPressed: () {
                      Modular.to.pushNamed('/mainboard/menu/profile_edit');
                    },
                  ),
                  _buildItemList(
                    title: 'Configurações',
                    icon: SvgPicture.asset(
                      'assets/images/svg/drawer/account_setting.svg',
                      colorFilter: const ColorFilter.mode(
                          DesignSystemColors.darkIndigoThree, BlendMode.srcIn),
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
                      colorFilter: const ColorFilter.mode(
                          DesignSystemColors.darkIndigoThree, BlendMode.srcIn),
                    ),
                    onPressed: () {
                      Modular.to.pushNamed('/mainboard/menu/account_delete');
                    },
                  ),
                  _buildItemList(
                    title: 'Sobre o PenhaS',
                    icon: SvgPicture.asset(
                      'assets/images/svg/drawer/menu_penhas_icone.svg',
                      colorFilter: const ColorFilter.mode(
                          DesignSystemColors.darkIndigoThree, BlendMode.srcIn),
                    ),
                    onPressed: () {
                      Modular.to.pushNamed('/mainboard/menu/about');
                    },
                  ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 126.0),
                    alignment: Alignment.bottomCenter,
                    child: PenhasButton.text(
                      onPressed: () => _controller.logoutPressed(),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                PenhasButton.text(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      TutorialScaleRoute(
                          page: StealthModeTutorialPage(
                        controller: _stealthController,
                      )),
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
      colorFilter: const ColorFilter.mode(
          DesignSystemColors.darkIndigo, BlendMode.srcIn),
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
}

extension _TextStyle on PenhasDrawerPageState {
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
