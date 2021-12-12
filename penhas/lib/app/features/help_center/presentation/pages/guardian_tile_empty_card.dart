import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_tile_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class GuardianTileEmptyCard extends StatelessWidget {
  const GuardianTileEmptyCard({Key? key, required this.card}) : super(key: key);

  final GuardianTileEmptyCardEntity card;
  const GuardianTileEmptyCard({required Key key, required this.card}) : super(key: key);

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
                color: DesignSystemColors.cobaltTwo,
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
