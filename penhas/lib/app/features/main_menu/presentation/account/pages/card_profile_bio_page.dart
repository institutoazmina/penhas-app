import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'card_profile_header_edit_page.dart';

class CardProfileBioPage extends StatelessWidget {
  final String content;
  final void Function() onEditAction;

  const CardProfileBioPage({
    Key key,
    @required this.content,
    @required this.onEditAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: DesignSystemColors.pinkishGrey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: Column(
          children: [
            CardProfileHeaderEditPage(
                title: "Minibio", onEditAction: onEditAction),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 20.0),
              child: Text(content),
            )
          ],
        ),
      ),
    );
  }
}
