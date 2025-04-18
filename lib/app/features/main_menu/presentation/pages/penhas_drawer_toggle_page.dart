import 'package:flutter/material.dart';

import '../../../../core/states/security_toggle_state.dart';
import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';

class PenhasDrawerTogglePage extends StatelessWidget {
  const PenhasDrawerTogglePage({
    super.key,
    required this.state,
  });

  final SecurityToggleState state;

  @override
  Widget build(BuildContext context) {
    const double listHeight = 80;
    const Color drawerGrey = Color.fromRGBO(239, 239, 239, 1.0);

    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      height: listHeight,
      decoration: const BoxDecoration(
        color: drawerGrey,
        border: Border(bottom: BorderSide(color: DesignSystemColors.white)),
      ),
      child: Center(
        child: SwitchListTile(
          contentPadding: const EdgeInsets.only(right: 16.0),
          value: state.isEnabled!,
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
