import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                  child: Text(card.name, style: kTextStyleGuardianCardTitle),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(card.mobile, style: kTextStyleGuardianCardMobile),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(card.status ?? "",
                      style: kTextStyleGuardianStatusMobile),
                ),
              ],
            ),
          ),
          _buildAction(_canEditIcon, card.onEditPressed),
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
}
