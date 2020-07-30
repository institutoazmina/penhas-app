import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/authentication/presentation/shared/input_box_style.dart';
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
      margin: EdgeInsets.only(top: 12.0),
      padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: DesignSystemColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 8.0,
          )
        ],
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
          _buildDeleteAction(card.onDeletePressed),
          _buildResendAction(card.onResendPressed),
        ],
      ),
    );
  }

  Widget _buildEditAction(void Function(String name) action) {
    return optionOf(action).fold(
      () => Container(),
      (a) => IconButton(
        icon: _canEditIcon,
        onPressed: () => _onEditPressed(a),
      ),
    );
  }

  Widget _buildDeleteAction(void Function() action) {
    return optionOf(action).fold(
      () => Container(),
      (a) => IconButton(
        icon: _canDeleteIcon,
        onPressed: () => _onDeletePressed(a),
      ),
    );
  }

  Widget _buildResendAction(void Function() action) {
    return optionOf(action).fold(
      () => Container(),
      (a) => IconButton(
        icon: _canResendIcon,
        onPressed: () => _onResendPressed(a),
      ),
    );
  }

  void _onEditPressed(void Function(String name) action) {
    Modular.to.showDialog(
      builder: (context) {
        TextEditingController _controller = TextEditingController();

        return AlertDialog(
          title: Text('Alterar nome', style: kTextStyleAlertDialogTitle),
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
              onPressed: () {
                Modular.to.pop();
              },
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
        title: Text('Apagar', style: kTextStyleAlertDialogTitle),
        content: Text(
          card.deleteWarning ?? 'Deseja excluir ${card.guardian.name}?',
          style: kTextStyleAlertDialogDescription,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Não'),
            onPressed: () {
              Modular.to.pop();
            },
          ),
          FlatButton(
            child: Text('Sim'),
            onPressed: () {
              action();
              Modular.to.pop();
            },
          )
        ],
      ),
      barrierDismissible: true,
    );
  }

  void _onResendPressed(void Function() action) {
    Modular.to.showDialog(
      child: AlertDialog(
        title: Text('Reenviar', style: kTextStyleAlertDialogTitle),
        content: Text(
          'Deseja reenviar o convite para ${card.guardian.name}?',
          style: kTextStyleAlertDialogDescription,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Não'),
            onPressed: () {
              Modular.to.pop();
            },
          ),
          FlatButton(
            child: Text('Sim'),
            onPressed: () {
              action();
              Modular.to.pop();
            },
          )
        ],
      ),
      barrierDismissible: true,
    );
  }
}
