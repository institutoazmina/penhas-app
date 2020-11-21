import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/core/pages/tutorial_scale_route.dart';
import 'package:penhas/app/core/states/security_toggle_state.dart';
import 'package:penhas/app/features/main_menu/presentation/pages/penhas_drawer_header_page.dart';
import 'package:penhas/app/features/main_menu/presentation/pages/penhas_drawer_toogle_page.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/quiz_tutorial_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_controller.dart';

class PenhasDrawerPage extends StatefulWidget {
  final String title;
  const PenhasDrawerPage({Key key, this.title = "Penhas Drawer"})
      : super(key: key);

  @override
  _PenhasDrawerPageState createState() => _PenhasDrawerPageState();
}

class _PenhasDrawerPageState
    extends ModularState<PenhasDrawerPage, PenhasDrawerController> {
  final double listHeight = 80;
  final Color drawerGrey = Color.fromRGBO(239, 239, 239, 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
          child: Container(
        constraints: BoxConstraints.expand(
            width: MediaQuery.of(context).size.width - 60),
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
                Container(
                    margin: EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "O modo camuflado reduz a possibilidade d aut corporis consequatur voluptatem. Placeat et explicabo porro veritatis. Eum dicta error commodi.",
                          style: securityContextTextStyle,
                        ),
                        FlatButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              TutorialScaleRoute(page: QuizTutorialPage()),
                            );
                          },
                          child: Text("Como funciona",
                              style: securityTutorialButtonTextStyle),
                        )
                      ],
                    )),
                _buildItemList(
                  title: 'Informações pessoais',
                  icon: SvgPicture.asset(
                    "assets/images/svg/drawer/user_profile.svg",
                    color: DesignSystemColors.darkIndigoThree,
                  ),
                ),
                _buildItemList(
                  title: 'Preferência da conta',
                  icon: SvgPicture.asset(
                    "assets/images/svg/drawer/account_setting.svg",
                    color: DesignSystemColors.darkIndigoThree,
                  ),
                ),
                _buildItemList(
                  title: 'Exclusão da conta',
                  icon: SvgPicture.asset(
                    "assets/images/svg/drawer/trash.svg",
                    color: DesignSystemColors.darkIndigoThree,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minHeight: 126.0),
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                    onPressed: () => controller.logoutPressed(),
                    child: Row(
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
      )),
    );
  }

  Widget _buildAvatar(String avatarPath) {
    if (avatarPath == null || avatarPath.isEmpty) {
      return Container();
    }

    return SvgPicture.network(
      avatarPath,
      color: DesignSystemColors.darkIndigo,
      height: 36,
    );
  }

  Widget _buildItemList({@required String title, Widget icon}) {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      height: listHeight,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
              bottom: BorderSide(color: DesignSystemColors.pinkishGrey))),
      child: Row(
        children: <Widget>[
          SizedBox(height: 26.0, width: 26.0, child: icon),
          SizedBox(width: 9.0),
          Text(
            title,
            style: kTextStyleDrawerListItem,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityToggle(bool isVisible, SecurityToggleState state) {
    if (!isVisible) return Container();

    return PenhasDrawerTooglePage(state: state);
  }
}

extension _TextStyel on _PenhasDrawerPageState {
  TextStyle get securityContextTextStyle => TextStyle(
      color: DesignSystemColors.darkIndigoThree,
      fontFamily: 'Lato',
      fontSize: 14.0,
      fontWeight: FontWeight.normal);

  TextStyle get securityTutorialButtonTextStyle => TextStyle(
      color: DesignSystemColors.pinky,
      fontFamily: 'Lato',
      fontSize: 14.0,
      fontWeight: FontWeight.bold);
}
