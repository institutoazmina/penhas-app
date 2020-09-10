import 'package:flutter/material.dart';
import 'package:penhas/app/core/states/security_toggle_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class PenhasDrawerTooglePage extends StatelessWidget {
  final SecurityToggleState state;

  const PenhasDrawerTooglePage({
    Key key,
    @required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double listHeight = 80;
    final Color drawerGrey = Color.fromRGBO(239, 239, 239, 1.0);

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
          value: state.isEnabled,
          onChanged: state.onChanged,
          title: Text(
            state.title,
            style: kTextStyleDrawerListItem,
          ),
        ),
      ),
    );
  }
}