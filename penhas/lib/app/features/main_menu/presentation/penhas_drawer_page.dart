import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
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
          child: ListView(
            children: <Widget>[
              _builderHeader(),
              _buildAnonymousMode(),
              _buildStealthMode(),
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
                    )),
              ),
            ],
          ),
        ),
      ),
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

  Widget _buildStealthMode() {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      height: listHeight,
      color: drawerGrey,
      child: Center(
        child: SwitchListTile(
          contentPadding: EdgeInsets.only(left: 0.0, right: 16.0),
          value: false,
          onChanged: (_) {},
          title: Text(
            'Modo camuflado',
            style: kTextStyleDrawerListItem,
          ),
        ),
      ),
    );
  }

  Widget _buildAnonymousMode() {
    bool _lights = false;
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      height: listHeight,
      decoration: BoxDecoration(
          color: drawerGrey,
          shape: BoxShape.rectangle,
          border: Border(bottom: BorderSide(color: DesignSystemColors.white))),
      child: Center(
        child: SwitchListTile(
          contentPadding: EdgeInsets.only(left: 0.0, right: 16.0),
          value: _lights,
          onChanged: (_) {},
          title: Text(
            'Estou em situação de violência',
            style: kTextStyleDrawerListItem,
          ),
        ),
      ),
    );
  }

  Widget _builderHeader() {
    return Container();
    //   return Container(
    //     padding: EdgeInsets.only(left: 16.0),
    //     height: 100,
    //     child: Row(
    //       children: <Widget>[
    //         CircleAvatar(
    //           backgroundColor: drawerGrey,
    //           radius: 25,
    //           child: _userAvatar,
    //         ),
    //         SizedBox(width: 9.0),
    //         Text(
    //           _userName,
    //           style: kTextStyleDrawerUsername,
    //         ),
    //         SizedBox(width: 9.0),
    //         Container(
    //           padding: EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 4.0),
    //           decoration: BoxDecoration(
    //               color: Color.fromRGBO(234, 234, 234, 1),
    //               borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(6.0),
    //                 bottomLeft: Radius.circular(6.0),
    //                 bottomRight: Radius.circular(6.0),
    //               )),
    //           child: Text('Você', style: kTextStyleDrawerUserNameTag),
    //         ),
    //       ],
    //     ),
    //   );
  }
}

/*
  void initState() {
    super.initState();
    controller.userName.then((value) {
      setState(() {
        userName = value;
      });
    });
    controller.userAvatar
        .then((value) => SvgPicture.network(
              value,
              color: DesignSystemColors.darkIndigo,
              height: 36,
            ))
        .then((value) {
      setState(() {
        userAvatar = value;
      });
    });
  }
*/
