import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/authentication/presentation/shared/input_box_style.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_tile_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class GuardianTileActionCard extends StatelessWidget {
  final GuardianTileCardEntity card;
  const GuardianTileActionCard({
    Key key,
    @required this.card,
  }) : super(key: key);

  Widget get _canEditIcon => SvgPicture.asset(
        'assets/images/svg/help_center/guardians/guardians_edit.svg',
        color: DesignSystemColors.pumpkinOrange,
      );
  Widget get _canDeleteIcon => SvgPicture.asset(
        'assets/images/svg/help_center/guardians/guardians_delete.svg',
        color: DesignSystemColors.pumpkinOrange,
      );
  Widget get _canResendIcon => Icon(
        Icons.autorenew,
        color: DesignSystemColors.pumpkinOrange,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: DesignSystemColors.warnGrey),
          bottom: BorderSide(color: DesignSystemColors.warnGrey),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(card.guardian.name,
                      style: kTextStyleGuardianCardTitle),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(card.guardian.mobile,
                      style: kTextStyleGuardianCardMobile),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(card.guardian.status ?? "",
                      style: kTextStyleGuardianStatusMobile),
                ),
              ],
            ),
          ),
          _buildEditAction(card.onEditPressed),
          _buildAction(_canDeleteIcon, card.onDeletePressed),
          _buildAction(_canResendIcon, card.onResendPressed),
        ],
      ),
    );
  }

  Widget _buildAction(Widget icon, void Function() action) {
    return action == null
        ? Container()
        : IconButton(icon: icon, onPressed: action);
  }

  Widget _buildEditAction(void Function(String name) action) {
    return action == null
        ? Container()
        : IconButton(
            icon: _canEditIcon,
            onPressed: () => _onEditPressed(action),
          );
  }

  void _onEditPressed(void Function(String name) action) {
    Modular.to.showDialog(
      builder: (context) {
        TextEditingController _controller = TextEditingController();

        return AlertDialog(
          title: Text('Alterar nome'),
          content: TextFormField(
            style: kTextStyleGreyDefaultTextFieldLabelStyle,
            controller: _controller,
            maxLengthEnforced: true,
            decoration: PurpleBoxDecorationStyle(
              labelText: 'Novo nome',
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Fechar'),
              onPressed: () => Modular.to.canPop(),
            ),
            FlatButton(
              color: DesignSystemColors.easterPurple,
              child: Text('Enviar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                action(_controller.text);
                Modular.to.pop();
              },
            )
          ],
        );
      },
    );
  }

  void _onDeletePressed(void Function() action) {
    Modular.to.showDialog(
      child: AlertDialog(
        title: Text('Title'),
        content: Text('My content my _onDeletePressed'),
      ),
      barrierDismissible: true,
    );
  }

  void _onResendPressed(void Function() action) {
    Modular.to.showDialog(
      child: AlertDialog(
        title: Text('Title'),
        content: Text('My content my _onResendPressed'),
      ),
      barrierDismissible: true,
    );
  }
}
