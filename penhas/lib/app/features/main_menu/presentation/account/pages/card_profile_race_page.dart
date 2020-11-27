import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'card_profile_header_edit_page.dart';

class CardProfileRacePage extends StatelessWidget {
  final String content;
  final void Function(String) onChange;
  const CardProfileRacePage({
    Key key,
    @required this.content,
    @required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignSystemColors.systemBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfileHeaderEditPage(
              title: "Raça",
              onEditAction: () => showModal(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 20.0),
              child: Text(
                EnumHumanRace.map(content).label,
                style: contentTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension _Modal on CardProfileRacePage {
  void showModal() {
    Modular.to.showDialog(
      child: AlertDialog(
        title: Text('Raça'),
        scrollable: true,
        content: Container(
          height: 350,
          child: ListView.builder(
              itemCount: datasource().length,
              itemBuilder: (BuildContext context, int index) {
                return datasource()[index];
              }),
        ),
      ),
    );
  }
}

extension _TextStyle on CardProfileRacePage {
  TextStyle get contentTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}

extension _HumanMapper on CardProfileRacePage {
  List<Widget> datasource() {
    return HumanRace.values
        .map(
          (v) => ListTile(
              title: Text(v.label),
              leading: content == v.rawValue
                  ? Icon(Icons.check_circle_outlined)
                  : Container(width: 16),
              onTap: () => updateRace(v.rawValue)),
        )
        .toList();
  }

  void updateRace(String id) {
    onChange(id);
    Modular.to.pop();
  }
}
