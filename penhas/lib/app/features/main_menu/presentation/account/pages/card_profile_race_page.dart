import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/extension/asuka.dart';
import 'package:penhas/app/features/authentication/domain/usecases/human_race.dart';
import 'package:penhas/app/features/main_menu/presentation/account/pages/card_profile_header_edit_page.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class CardProfileRacePage extends StatelessWidget {
  final String? content;
  final void Function(String) onChange;
  const CardProfileRacePage({
    Key? key,
    required this.content,
    required this.onChange,
  }) : super(key: key);

  final String? content;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignSystemColors.systemBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfileHeaderEditPage(
              title: 'Raça',
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
      builder: (_) => AlertDialog(
        title: Text('Raça'),
        scrollable: true,
        content: SizedBox(
          height: 350,
          child: ListView(
            children: datasource(context),
          ),
        ),
      ),
    );
  }
}

extension _TextStyle on CardProfileRacePage {
  TextStyle get contentTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 14.0,
        letterSpacing: 0.45,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}

extension _HumanMapper on CardProfileRacePage {
  List<Widget> datasource(BuildContext context) {
    return HumanRace.values
        .map((v) => RadioListTile(
              value: v.rawValue,
              groupValue: this.content,
              selected: isSelected(v.rawValue),
              onChanged: (dynamic v) => updateRace(v),
              activeColor: DesignSystemColors.ligthPurple,
              title: Text(v.label, style: contentTextStyle),
            ))
        .toList();
  }

  void updateRace(String? id) {
    onChange(id ?? "");
    Modular.to.pop();
  }

  bool isSelected(String id) {
    return content == id;
  }
}
