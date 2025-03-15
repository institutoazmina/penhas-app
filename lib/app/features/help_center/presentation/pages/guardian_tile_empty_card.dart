import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../domain/entities/guardian_tile_entity.dart';

class GuardianTileEmptyCard extends StatelessWidget {
  const GuardianTileEmptyCard({super.key, required this.card});

  final GuardianTileEmptyCardEntity card;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => _onPressed(),
      child: Container(
        margin: const EdgeInsets.only(top: 12.0),
        padding: const EdgeInsets.all(8.0),
        height: 80,
        child: Row(
          children: <Widget>[
            Expanded(
              child: SvgPicture.asset(
                'assets/images/svg/bottom_bar/emergency_controll.svg',
                colorFilter: const ColorFilter.mode(
                    DesignSystemColors.cobaltTwo, BlendMode.color),
                height: 60,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: const TextSpan(
                    text: 'Você não possui guardiã(o) cadastrado e ativado. ',
                    style: kTextStyleAlertDialogDescription,
                    children: [
                      TextSpan(
                        text: 'Solicite um(a) guardiã(o) agora!',
                        style: kTextStyleFeedTweetShowReply,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed() {
    card.onPressed();
  }
}
