import 'package:flutter/material.dart';

import '../../../../shared/design_system/button_shape.dart';
import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';

class ChatPeopleFilterCard extends StatelessWidget {
  const ChatPeopleFilterCard({
    Key? key,
    this.totalOfFilter = 0,
    required this.onPressed,
  }) : super(key: key);

  final int totalOfFilter;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final filterTitle =
        (totalOfFilter > 0) ? 'Filtros ($totalOfFilter)' : 'Filtros';
    return Container(
      // height: 150,
      padding: const EdgeInsets.all(16.0),
      color: DesignSystemColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Rede de mulheres que querem ajudar', style: cardTitleTextStyle),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Text(
              'Escolha uma delas para conversar, desabafar ou tirar uma dúvida',
              style: describeTextStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                onPressed: onPressed,
                elevation: 0,
                color: DesignSystemColors.ligthPurple,
                shape: kButtonShapeFilled,
                child: Text(
                  filterTitle,
                  style: kTextStyleDefaultFilledButtonLabel,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

extension _ChatPeopleFilterCardTextStyle on ChatPeopleFilterCard {
  TextStyle get cardTitleTextStyle => const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Lato',
        letterSpacing: 0.4,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );

  TextStyle get describeTextStyle => const TextStyle(
        height: 1.3,
        fontSize: 14.0,
        fontFamily: 'Lato',
        letterSpacing: 0.4,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.normal,
      );
}
